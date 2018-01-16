//
//  JGGPostServiceAddressVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceAddressVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var txtUnits: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var btnDontShowFullAddress: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUnits.delegate = self
        txtStreet.delegate = self
        txtPostcode.delegate = self
        
        txtUnits.text = nil
        txtStreet.text = nil
        txtPostcode.text = nil

    }

    @IBAction func onPressedDontShowMyFullAddress(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func onPressedNext(_ sender: UIButton) {
        super.onPressedNext(sender)
        if let parentVC = parent as? JGGPostServiceStepRootVC {
            parentVC.gotoSummaryVC()
        }
    }

    
}

extension JGGPostServiceAddressVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField ==  txtUnits {
            txtStreet.becomeFirstResponder()
        }
        else if textField == txtStreet {
            txtPostcode.becomeFirstResponder()
        }
        else if textField == txtPostcode {
            txtPostcode.resignFirstResponder()
        }
        return true
    }
}
