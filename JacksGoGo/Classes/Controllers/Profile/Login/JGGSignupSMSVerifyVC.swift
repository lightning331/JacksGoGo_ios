//
//  JGGSignupSMSVerifyVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSignupSMSVerifyVC: JGGLoginBaseVC, UITextFieldDelegate {

    @IBOutlet weak var lblTimeInterval: UILabel!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var phoneNumber: String!
    
    private var counter: Int = 60
    private var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.keyboardDismissMode = .onDrag
        txtCode.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtCode.delegate = self

        resetTimer()
        let _ = checkValidCreditional()

    }
    
    private func resetTimer() {
        counter = 10
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(countTime(_:)),
                                     userInfo: nil, repeats: true)
        countTime(nil)
    }
    
    @objc private func countTime(_ sender: Any?) {
        counter -= 1
        self.lblTimeInterval.text = String(format: "%d s", counter)
        if counter <= 0 {
            timer?.invalidate()
            timer = nil
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    @IBAction func onPressedResendOTP(_ sender: UIButton) {
        self.showHUD()
        APIManager.accountAddPhone(phoneNumber) { (success, errorMessage) in
            self.hideHUD()
            if success {
                self.resetTimer()
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
            } else {
                self.showAlert(title: LocalizedString("Error"), message: errorMessage)
            }
        }

    }
    
    @IBAction func onPressedSubmit(_ sender: UIButton) {
        self.showHUD()
        APIManager.verifyPhoneNumber(self.phoneNumber, code: self.txtCode.text!) { (user, errorMessage) in
            self.hideHUD()
            if let user = user {
                self.appManager.currentUser = user
                (self.navigationController as! JGGProfileNC).loggedIn()
            } else {
                self.showAlert(title: LocalizedString("Error"), message: errorMessage)
            }
        }
    }
    
    private func checkValidCreditional() -> Bool {
        if let code = txtCode.text, code.count >= 6 {
                solidButton(btnSubmit, enable: true)
                return true
        }
        solidButton(btnSubmit, enable: false)
        return false
    }
    
    // MARK: - UITextField delegate
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        let _ = checkValidCreditional()
    }

    //MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return counter > 0 ? 0 : 64
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

}
