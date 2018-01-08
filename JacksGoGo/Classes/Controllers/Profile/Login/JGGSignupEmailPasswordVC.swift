//
//  JGGSignupEmailPasswordVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSignupEmailPasswordVC: JGGLoginBaseVC, UITextFieldDelegate {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtPassword.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtConfirmPassword.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        let _ = checkValidCreditional()

    }
    
    // MARK: - Button Actions
    
    @IBAction func onPressedSignup(_ sender: UIButton) {
        showHUD(to: self.navigationController?.tabBarController?.view)
        guard let email = txtEmail.text, let password = txtPassword.text else {
            self.showAlert(title: LocalizedString("Invalid"), message: LocalizedString("Please input your email and password."))
            return
        }
        self.view.endEditing(true)
        APIManager.accountRegister(email: email, password: password) { (success, errorMessage) in
            self.hideHUD(from: self.navigationController?.tabBarController?.view)
            if success {
                self.appManager.save(username: email, password: password)
                self.performSegue(withIdentifier: "gotoPhoneNumberVC", sender: self)
            } else {
                self.showAlert(title: LocalizedString("Error"), message: errorMessage)
            }
        }
    }
    
    @IBAction func onPressedFacebook(_ sender: UIButton) {
    }
    
    private func checkValidCreditional() -> Bool {
        if let email = txtEmail.text,
           let password = txtPassword.text,
           let confirmPassword = txtConfirmPassword.text
        {
            if email.count > 5 && password.count >= 6 && password == confirmPassword {
                solidButton(btnSignup, enable: true)
                return true
            }
        }
        solidButton(btnSignup, enable: false)
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
            txtConfirmPassword.becomeFirstResponder()
        } else if textField == txtConfirmPassword {
            txtConfirmPassword.resignFirstResponder()
            if checkValidCreditional() {
                onPressedSignup(btnSignup)
            }
        }
        return false
    }

    //MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}
