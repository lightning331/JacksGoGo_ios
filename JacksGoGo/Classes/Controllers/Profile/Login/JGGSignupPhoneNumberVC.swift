//
//  JGGSignupPhoneNumberVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import CountryPicker
import SnapKit

class JGGSignupPhoneNumberVC: JGGViewController, CountryPickerDelegate, UITextFieldDelegate {

    @IBOutlet weak var btnRegion: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var countryPicker: CountryPicker! // = CountryPicker()
    @IBOutlet weak var constraintBottomSpaceOfPicker: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hidesBottomBarWhenPushed = true
        txtPhoneNumber.delegate = self
        txtPhoneNumber.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        initCountryPicker()
        let _ = checkValidCreditional()
        

    }
    
    private func initCountryPicker() {
        
        countryPicker.displayOnlyCountriesWithCodes = ["SG", "MY", "CN"] //Optional, must be set before showing
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = true
        countryPicker.backgroundColor = UIColor.JGGOrange10Percent
        //get corrent country
        let locale = Locale.current
        if let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String {
            countryPicker.setCountry(code)
        }
        self.constraintBottomSpaceOfPicker.constant = 180
        self.updateConstraint(false)
    }
    
    // MARK: - Button Actions
    
    @IBAction func onPressedBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func onPressedRegion(_ sender: UIButton) {
        self.txtPhoneNumber.resignFirstResponder()
        self.constraintBottomSpaceOfPicker.constant = 0
        self.updateConstraint(true)
    }
    
    @IBAction func onPressedNext(_ sender: UIButton) {
        self.showHUD()
        let phoneNumber = self.btnRegion.title(for: .normal)! + self.txtPhoneNumber.text!
        APIManager.accountAddPhone(phoneNumber) { (success, errorMessage) in
            self.hideHUD()
            if success {
                self.performSegue(withIdentifier: "gotoSMSVerifyVC", sender: phoneNumber)
            } else {
                self.showAlert(title: LocalizedString("Error"), message: errorMessage)
            }
        }
    }
    
    private func checkValidCreditional() -> Bool {
        if let phoneNumber = self.txtPhoneNumber.text, phoneNumber.count >= 8 {
            solidButton(btnNext, enable: true)
            return true
        }
        solidButton(btnNext, enable: false)
        return false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    // MARK: - UITextField delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.constraintBottomSpaceOfPicker.constant == 0 {
            self.constraintBottomSpaceOfPicker.constant = 180
            self.updateConstraint(true)
        }
        return true
    }
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        let _ = checkValidCreditional()
    }
    
    // MARK: - CountryPicker delegate
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.btnRegion.setImage(flag, for: .normal)
        self.btnRegion.setTitle(phoneCode, for: .normal)
    }
    
    // MARK: - Navigation Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "gotoSMSVerifyVC" {
                let verifyVC = segue.destination as! JGGSignupSMSVerifyVC
                verifyVC.phoneNumber = sender as! String
            }
        }
    }
}
