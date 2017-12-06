//
//  JGGPostServicePriceVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServicePriceVC: JGGPostServiceBaseTableVC {
    
    fileprivate var selectedPriceType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.isHidden = false
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedPriceType > 0 {
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServicePriceTypeCell") as! JGGPostServicePriceTypeCell
            cell.selectingHandler = { index in
                self.selectedPriceType = index
                self.tableView.reloadData()
            }
            return cell
        } else if indexPath.row == 1 {
            
            if selectedPriceType == 1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServicePriceOneTimeCell") as! JGGPostServicePriceOneTimeCell
                cell.priceChangedHandler = { (type, price, maxPrice) in
                    
                }
                cell.changedTypeHandler = {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
                return cell
                
            } else if selectedPriceType == 2 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServicePricePackageCell") as! JGGPostServicePricePackageCell
                cell.changedNumberOfServiceHandler = { number in
                    
                }
                cell.changedAmountHandler = { amount in
                    
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
    
    var selectingHandler: ((Int) -> Void)!
    
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
        selectingHandler(index)
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

    var priceChangedHandler: ((Int, Float, Float) -> Void)!
    var changedTypeHandler: (() -> Void)!
    
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
        if sender.selected() {
            if sender == btnFixedAmount {
                viewFixedAmount.isHidden = false
                btnRangeAmount.isHidden = true
                viewMinPrice.isHidden = true
                viewMaxPrice.isHidden = true
            }
            else if sender == btnRangeAmount {
                viewFixedAmount.isHidden = true
                btnFixedAmount.isHidden = true
                viewMinPrice.isHidden = false
                viewMaxPrice.isHidden = false
            }
        } else {
            btnFixedAmount.isHidden = false
            btnRangeAmount.isHidden = false
            viewFixedAmount.isHidden = true
            viewMinPrice.isHidden = true
            viewMaxPrice.isHidden = true
        }
        changedTypeHandler()
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
                priceChangedHandler(selectedType, Float(textfield.text!) ?? 0, 0)
            }
            else {
                priceChangedHandler(selectedType, Float(txtMinPrice.text!) ?? 0, Float(txtMaxPrice.text!) ?? 0)
            }
        }
    }
}

class JGGPostServicePricePackageCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var txtNumberOfService: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    
    var changedNumberOfServiceHandler: ((Int) -> Void)!
    var changedAmountHandler:((Float) -> Void)!
    
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
            changedAmountHandler(Float(txtAmount.text!) ?? 0)
        }
    }
}
