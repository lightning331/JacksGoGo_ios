//
//  JGGLoginVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGLoginVC: JGGLoginBaseVC, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var btnSigninFacebook: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tableView.keyboardDismissMode = .onDrag
        
        txtEmail.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        txtEmail.text = "rose.lim@jgg.co"
        txtPassword.text = "abc123Q!@#"
        
        let _ = checkValidCreditional()
    }
    
    //MARK: - Button Actions
    @IBAction func onPressedForgotPassword(_ sender: UIButton) {
    
    }
    
    @IBAction func onPressedSignin(_ sender: UIButton) {
        showHUD(to: self.navigationController?.tabBarController?.view)
        guard let email = txtEmail.text, let password = txtPassword.text else {
            self.showAlert(title: LocalizedString("Invalid"), message: LocalizedString("Please input your email and password."))
            return
        }
        self.view.endEditing(true)
        APIManager.oauthToken(user: email, password: password) { (success, errorString) in
            if success {
                
                self.APIManager.accountLogin(email: email, password: password, complete: { (userProfile, errorMessage) in
                    self.hideHUD(from: self.navigationController?.tabBarController?.view)
                    if let userProfile = userProfile {
                        self.appManager.currentUser = userProfile
                        if userProfile.user.phoneNumberVerified {
                            let nav = self.navigationController as! JGGProfileNC
                            nav.loggedIn()
                            self.appManager.save(username: email, password: password)
                        } else {
                            JGGAlertViewController.show(title: LocalizedString("Warning"),
                                                        message: LocalizedString("You have not verified account. Would you verify with your phone number?"),
                                                        colorSchema: .orange,
                                                        okButtonTitle: LocalizedString("Verify"),
                                                        okAction: {
                                                            self.performSegue(withIdentifier: "gotoPhoneVerifyVC", sender: self)
                                                        },
                                                        cancelButtonTitle: LocalizedString("Cancel"),
                                                        cancelAction: nil)
                        }
                    } else {
                        self.showAlert(title: LocalizedString("Error"), message: errorMessage)
                    }
                })
                
            } else {
                self.hideHUD(from: self.navigationController?.tabBarController?.view)
                self.showAlert(title: LocalizedString("Error"), message: errorString)
            }
        }
    }
    
    @IBAction func onPressedFacebook(_ sender: UIButton) {
    
    }
    
    
    private func checkValidCreditional() -> Bool {
        if let email = txtEmail.text, let password = txtPassword.text {
            if email.count > 5 && password.count >= 6 {
                solidButton(btnSignin, enable: true)
                return true
            }
        }
        solidButton(btnSignin, enable: false)
        return false
    }
    
    // MARK: - UITextField delegate
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        let _ = checkValidCreditional()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        } else if textField == txtPassword {
            txtPassword.resignFirstResponder()
            if checkValidCreditional() {
                onPressedSignin(btnSignin)
            }
        }
        return false
    }
    
    //MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
