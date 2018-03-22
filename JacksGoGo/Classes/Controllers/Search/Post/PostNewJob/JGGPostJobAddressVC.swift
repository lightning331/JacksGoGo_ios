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

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
        self.view.endEditing(true)
        if let parentVC = parent as? JGGPostJobStepRootVC {
            var creatingJob: JGGJobModel?
            if parentVC.editingJob != nil {
                creatingJob = parentVC.editingJob
            } else {
                creatingJob = parentVC.creatingJob
            }
            if let creatingJob = creatingJob {
                let addressModel = JGGAddressModel()
                addressModel.unit = txtUnits.text
                addressModel.floor = txtPlaceName.text
                addressModel.address = txtStreet.text
                addressModel.postalCode = txtPostcode.text
                addressModel.lat = (selectedCoordinate?.latitude ?? 0)!
                addressModel.lon = (selectedCoordinate?.longitude ?? 0)!

                creatingJob.address = addressModel
            }
        }
    }
    
}
