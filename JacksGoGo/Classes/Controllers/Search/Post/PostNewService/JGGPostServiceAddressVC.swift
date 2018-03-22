//
//  JGGPostServiceAddressVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster
import CoreLocation

class JGGPostServiceAddressVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var txtPlaceName: UITextField!
    @IBOutlet weak var txtUnits: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var btnDontShowFullAddress: UIButton?
    
    internal var selectedPlacemark: CLPlacemark?
    internal var selectedCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtPlaceName.delegate = self
        txtUnits.delegate = self
        txtStreet.delegate = self
        txtPostcode.delegate = self
        
        txtPlaceName.text = nil
        txtUnits.text = nil
        txtStreet.text = nil
        txtPostcode.text = nil
        
        if SHOW_TEMP_DATA {
            showTemporaryData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showOriginalInfo()
        
    }

    private func showTemporaryData() {
        txtPlaceName.text = "My home"
        txtUnits.text = "20"
        txtStreet.text = "wanchingru 200"
        txtPostcode.text = "118000"
    }
    
    private func showOriginalInfo() {
        if let parent = self.parent as? JGGPostStepRootBaseVC,
            let editingJob = parent.editingJob
        {
            let addressModel = editingJob.address
            txtUnits.text = addressModel?.unit
            txtPlaceName.text = addressModel?.floor
            txtStreet.text = addressModel?.address
            txtPostcode.text = addressModel?.postalCode
            if let btnDontShowFullAddress = btnDontShowFullAddress {
                btnDontShowFullAddress.isSelected = addressModel?.isDontShowFullAddress ?? false
            }
        }
    }

    override func updateData(_ sender: Any) {
        self.view.endEditing(true)
        if let parentVC = parent as? JGGPostServiceStepRootVC {
            let addressModel = JGGAddressModel()
            addressModel.unit = txtUnits.text
            addressModel.floor = txtPlaceName.text
            addressModel.address = txtStreet.text
            addressModel.postalCode = txtPostcode.text
            addressModel.lat = (selectedCoordinate?.latitude ?? 0)!
            addressModel.lon = (selectedCoordinate?.longitude ?? 0)!
            if let btnDontShowFullAddress = btnDontShowFullAddress {
                addressModel.isDontShowFullAddress = btnDontShowFullAddress.isSelected
            }
            let creatingService = parentVC.creatingJob
            creatingService?.address = addressModel
        }
    }
    
    @IBAction func onPressedDontShowMyFullAddress(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

    @IBAction func onPressedSelectLocation(_ sender: UIButton) {
        let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGSelectLocationMapVC") as! JGGSelectLocationMapVC
        mapVC.selectedLocationHandler = { placemark, coordinate in
            self.txtPlaceName.text = nil
            self.txtUnits.text = nil
            let formattedAddress = (placemark?.addressDictionary?["FormattedAddressLines"] as? [String])?.joined(separator: ", ")
            self.txtStreet.text = formattedAddress
            self.txtPostcode.text = placemark?.postalCode
            self.selectedPlacemark = placemark
            self.selectedCoordinate = coordinate
        }
        if let selectedCoordinate = selectedCoordinate {
            mapVC.currentCoordinate = selectedCoordinate
        }
        let nav = JGGBaseNC(rootViewController: mapVC)
        self.present(nav, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func onPressedNext(_ sender: UIButton) {
        if let unit = txtUnits.text, let street = txtStreet.text, let postalCode = txtPostcode.text {
            if unit.count > 0 && street.count > 0 && postalCode.count > 0 {
                super.onPressedNext(sender)
                
                NotificationCenter.default.post(name: NotificationUpdateJobContents, object: nil)
                
                if let parentVC = parent as? JGGPostServiceStepRootVC {
                    parentVC.stepView.completeCurrentStep()
                    parentVC.gotoSummaryVC()
                }
                return
            }
        }
        Toast(text: LocalizedString("Please enter where do you need the service."), delay: 0, duration: 3).show()
    }
}

extension JGGPostServiceAddressVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtPlaceName {
            txtUnits.becomeFirstResponder()
        } else if textField ==  txtUnits {
            txtStreet.becomeFirstResponder()
        }
        else if textField == txtStreet {
            txtPostcode.becomeFirstResponder()
        }
        else if textField == txtPostcode {
            txtPostcode.resignFirstResponder()
        }
        return false
    }
}
