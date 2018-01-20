//
//  JGGPostServicePriceVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGPostServicePriceVC: JGGPostAppointmentBaseTableVC {
    
    fileprivate var selectedServiceType: Int = 0 // 0: No selected, 1: One-time, 2: Package
    fileprivate var priceType: Int = 0
    fileprivate var fixedPrice: Double = 0
    fileprivate var minPrice: Double = 0
    fileprivate var maxPrice: Double = 0
    fileprivate var packageNo: Int = 0
    fileprivate var packagePrice: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.isHidden = false
        
    }

    override func onPressedNext(_ sender: UIButton) {
        var errorMessage: String? = nil
        
        if selectedServiceType == 0 {
            errorMessage = LocalizedString("Please select a price type.")
        } else if selectedServiceType == 1 {
            if priceType == 1 {
                if fixedPrice == 0 {
                    errorMessage = LocalizedString("Please enter greater fixed price than 0.")
                }
            } else if priceType == 2 {
                if minPrice > maxPrice {
                    errorMessage = LocalizedString("Please enter less min price than max price.")
                }
            } else {
                errorMessage = LocalizedString("Please enter price.")
            }
        } else if selectedServiceType == 2 {
            if packageNo < 2 || packagePrice == 0 {
                errorMessage = LocalizedString("Please enter package no. 2+ and price")
            }
        }
        if errorMessage == nil {
            super.onPressedNext(sender)
        } else {
            Toast(text: errorMessage, delay: 0, duration: 3).show()
        }
    }
    
    override func updateData(_ sender: Any) {
        if let parentVC = parent as? JGGPostServiceStepRootVC {
            let creatingService = parentVC.creatingJob!
            creatingService.budget = nil
            creatingService.budgetFrom = nil
            creatingService.budgetTo = nil
            if selectedServiceType == 1 {
                creatingService.serviceType = 1
                if priceType == 1 {
                    creatingService.budget = fixedPrice
                } else if priceType == 2 {
                    creatingService.budgetFrom = minPrice
                    creatingService.budgetTo = maxPrice
                }
            } else if selectedServiceType == 2 {
                creatingService.serviceType = self.packageNo
                creatingService.budget = self.packagePrice
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedServiceType > 0 {
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServicePriceTypeCell") as! JGGPostServicePriceTypeCell
            cell.changedTypeHandler = { index in
                self.selectedServiceType = index
                self.tableView.reloadData()
            }
            return cell
        } else if indexPath.row == 1 {
            
            if selectedServiceType == 1 { // One-Time
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServicePriceOneTimeCell") as! JGGPostServicePriceOneTimeCell
                cell.priceChangedHandler = { (type, price, maxPrice) in
                    if type == 1 {
                        self.fixedPrice = price
                        self.minPrice = 0
                        self.maxPrice = 0
                    } else if type == 2 {
                        self.fixedPrice = 0
                        self.minPrice = price
                        self.maxPrice = maxPrice
                    }
                    self.priceType = type
                }
                cell.changedTypeHandler = { (type) in
                    self.priceType = type
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
                return cell
                
            } else if selectedServiceType == 2 {  // package
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServicePricePackageCell") as! JGGPostServicePricePackageCell
                cell.changedNumberOfServiceHandler = { number in
                    self.packageNo = number
                }
                cell.changedAmountHandler = { amount in
                    self.packagePrice = amount
                }
                return cell
                
            }
            
        }
        return UITableViewCell()
    }

}

class JGGPostServicePriceTypeCell: UITableViewCell {
    
    @IBOutlet weak var btnOneTimeService: JGGYellowSelectingButton!
    @IBOutlet weak var btnPackageService: JGGYellowSelectingButton!
    
    var changedTypeHandler: ((Int) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction fileprivate func onPressedButton(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        var index: Int = 0
        if sender.selected() {
            if sender == btnOneTimeService {
                index = 1
                btnPackageService.isHidden = true
                btnPackageService.select(false)
            }
            else if sender == btnPackageService {
                index = 2
                btnOneTimeService.isHidden = true
                btnOneTimeService.select(false)
            }
        } else {
            btnOneTimeService.isHidden = false
            btnPackageService.isHidden = false
        }
        changedTypeHandler(index)
    }
}

class JGGPostServicePriceOneTimeCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var btnFixedAmount: JGGYellowSelectingButton!
    @IBOutlet weak var viewFixedAmount: UIView!
    @IBOutlet weak var txtFixedAmount: UITextField!
    
    @IBOutlet weak var btnRangeAmount: JGGYellowSelectingButton!
    @IBOutlet weak var viewMinPrice: UIView!
    @IBOutlet weak var txtMinPrice: UITextField!
    @IBOutlet weak var viewMaxPrice: UIView!
    @IBOutlet weak var txtMaxPrice: UITextField!

    var priceChangedHandler: ((Int, Double, Double) -> Void)!
    var changedTypeHandler: ((Int) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtFixedAmount.delegate = self
        txtMinPrice.delegate = self
        txtMaxPrice.delegate = self
        txtFixedAmount.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: .editingChanged)
        txtMinPrice.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: .editingChanged)
        txtMaxPrice.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: .editingChanged)
        txtFixedAmount.keyboardType = .numbersAndPunctuation
        txtMinPrice.keyboardType = .numbersAndPunctuation
        txtMaxPrice.keyboardType = .numbersAndPunctuation
        
        viewFixedAmount.isHidden = true
        viewMinPrice.isHidden = true
        viewMaxPrice.isHidden = true
        
    }
    
    @IBAction fileprivate func onPressedButton(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        var priceType: Int = 0
        if sender.selected() {
            if sender == btnFixedAmount {
                viewFixedAmount.isHidden = false
                btnRangeAmount.isHidden = true
                viewMinPrice.isHidden = true
                viewMaxPrice.isHidden = true
                priceType = 1
            }
            else if sender == btnRangeAmount {
                viewFixedAmount.isHidden = true
                btnFixedAmount.isHidden = true
                viewMinPrice.isHidden = false
                viewMaxPrice.isHidden = false
                priceType = 2
            }
        } else {
            btnFixedAmount.isHidden = false
            btnRangeAmount.isHidden = false
            viewFixedAmount.isHidden = true
            viewMinPrice.isHidden = true
            viewMaxPrice.isHidden = true
        }
        changedTypeHandler(priceType)
    }
    
    @objc func textfieldDidChanged(_ textfield: UITextField) {
        var selectedType: Int = 0
        if btnFixedAmount.selected() {
            selectedType = 1
        } else if btnRangeAmount.selected() {
            selectedType = 2
        }
        if selectedType > 0 {
            if selectedType == 1 && textfield == txtFixedAmount {
                priceChangedHandler(selectedType, Double(textfield.text!) ?? 0, 0)
            }
            else {
                priceChangedHandler(selectedType, Double(txtMinPrice.text!) ?? 0, Double(txtMaxPrice.text!) ?? 0)
            }
        }
    }
}

class JGGPostServicePricePackageCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var txtNumberOfService: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    
    var changedNumberOfServiceHandler: ((Int) -> Void)!
    var changedAmountHandler:((Double) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtNumberOfService.delegate = self
        txtAmount.delegate = self
        txtNumberOfService.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: .editingChanged)
        txtAmount.addTarget(self, action: #selector(textfieldDidChanged(_:)), for: .editingChanged)
        txtNumberOfService.keyboardType = .numbersAndPunctuation
        txtAmount.keyboardType = .numbersAndPunctuation
    }
    
    @objc func textfieldDidChanged(_ textfield: UITextField) {
        if textfield == txtNumberOfService {
            changedNumberOfServiceHandler(Int(txtNumberOfService.text!) ?? 0)
        } else if textfield == txtAmount {
            changedAmountHandler(Double(txtAmount.text!) ?? 0)
        }
    }
}
