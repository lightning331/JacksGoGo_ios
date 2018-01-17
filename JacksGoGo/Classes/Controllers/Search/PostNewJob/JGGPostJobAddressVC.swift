//
//  JGGPostJobAddressVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGPostJobAddressVC: JGGPostServiceAddressVC {

    @IBOutlet weak var txtPlaceName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPlaceName.text = nil
        
        txtPlaceName.delegate = self
        
        if SHOW_TEMP_DATA {
            showTemporaryData()
        }
    }
    
    private func showTemporaryData() {
        txtPlaceName.text = "My home"
        txtUnits.text = "20"
        txtStreet.text = "wanchingru 200"
        txtPostcode.text = "118000"
    }

    override func onPressedNext(_ sender: UIButton) {
        if let unit = txtUnits.text, let street = txtStreet.text, let postalCode = txtPostcode.text {
            if unit.count > 0 && street.count > 0 && postalCode.count > 0 {
                super.onPressedNext(sender)
                return
            }
        }
        Toast(text: LocalizedString("Please enter where do you need the service."), delay: 0, duration: 3).show()
    }
    
    override func updateData(_ sender: Any) {
        if let parentVC = parent as? JGGPostJobStepRootVC {
            let addressModel = JGGAddressModel()
            addressModel.unit = txtUnits.text
            addressModel.floor = txtPlaceName.text
            addressModel.address = txtStreet.text
            addressModel.postalCode = txtPostcode.text
            
            let creatingJob = parentVC.creatingJob
            creatingJob.address = addressModel
        }
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtPlaceName {
            txtUnits.becomeFirstResponder()
            return true
        } else {
            return super.textFieldShouldReturn(textField)
        }
    }
}
