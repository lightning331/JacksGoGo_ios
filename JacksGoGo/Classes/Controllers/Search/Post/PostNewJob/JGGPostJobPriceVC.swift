//
//  JGGPostJobPriceVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGPostJobPriceVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var btnNoLimits: JGGYellowSelectingButton!
    @IBOutlet weak var btnFixedAmount: JGGYellowSelectingButton!
    @IBOutlet weak var btnRangeAmount: JGGYellowSelectingButton!

    @IBOutlet weak var viewNoLimitsDescription: UIView!
    @IBOutlet weak var viewFixedAmount: UIView!
    @IBOutlet weak var txtFixedAmount: UITextField!
    @IBOutlet weak var viewRangeMinAmount: UIView!
    @IBOutlet weak var txtRangeMinAmount: UITextField!
    @IBOutlet weak var viewRangeMaxAmount: UIView!
    @IBOutlet weak var txtRangeMaxAmount: UITextField!
    
    fileprivate var selectedPriceType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnNoLimits.defaultColor = UIColor.JGGCyan
        btnFixedAmount.defaultColor = UIColor.JGGCyan
        btnRangeAmount.defaultColor = UIColor.JGGCyan
        
        viewNoLimitsDescription.isHidden = true
        viewFixedAmount.isHidden = true
        viewRangeMinAmount.isHidden = true
        viewRangeMaxAmount.isHidden = true

        btnNext.isHidden = false
        if SHOW_TEMP_DATA {
            showTemporaryData()
        }
    }
    
    private func showTemporaryData() {
        selectedPriceType = 2
        txtFixedAmount.text = "50.5"
    }

    override func onPressedNext(_ sender: UIButton) {
        if selectedPriceType == 0 {
            Toast(text: LocalizedString("Please set job budget."), delay: 0, duration: 3).show()
            return
        } else {
            if selectedPriceType == 2 {
                guard let fixedAmountString = txtFixedAmount.text, let amount = Double(fixedAmountString), amount > 0 else {
                    Toast(text: LocalizedString("Please enter correct amount for fixed job."), delay: 0, duration: 3).show()
                    return
                }
            }
            else if selectedPriceType == 3 {
                guard let minAmountString = txtRangeMinAmount.text, let minAmount = Double(minAmountString),
                    let maxAmountString = txtRangeMaxAmount.text, let maxAmount = Double(maxAmountString),
                    ((maxAmount > 0) && (minAmount <= maxAmount)) else {
                    Toast(text: LocalizedString("Please enter correct amount for flexible job."), delay: 0, duration: 3).show()
                    return
                }
            }
        }
        
        super.onPressedNext(sender)

    }
    
    override func updateData(_ sender: Any) {
        if let parentVC = parent as? JGGPostJobStepRootVC,
            let creatingJob = parentVC.creatingJob
        {
            creatingJob.budget = nil
            creatingJob.budgetFrom = nil
            creatingJob.budgetTo = nil
            if selectedPriceType == 2 {
                creatingJob.budget = Double(txtFixedAmount.text ?? "0")
            }
            else if selectedPriceType == 3 {
                creatingJob.budgetFrom = Double(txtRangeMinAmount.text ?? "0")
                creatingJob.budgetTo = Double(txtRangeMaxAmount.text ?? "0")
            }
        }
    }
    
    @IBAction private func onPressedPriceType(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        
        viewNoLimitsDescription.isHidden = true
        viewFixedAmount.isHidden = true
        viewRangeMinAmount.isHidden = true
        viewRangeMaxAmount.isHidden = true

        var index: Int = 0
        if sender.selected() {
            
            if sender == btnNoLimits {
                index = 1
                btnFixedAmount.isHidden = true
                btnFixedAmount.select(false)
                btnRangeAmount.isHidden = true
                btnRangeAmount.select(false)
                viewNoLimitsDescription.isHidden = false
            } else if sender == btnFixedAmount {
                index = 2
                btnNoLimits.isHidden = true
                btnNoLimits.select(false)
                btnRangeAmount.isHidden = true
                btnRangeAmount.select(false)
                viewFixedAmount.isHidden = false
            }
            else if sender == btnRangeAmount {
                index = 3
                btnNoLimits.isHidden = true
                btnNoLimits.select(false)
                btnFixedAmount.isHidden = true
                btnFixedAmount.select(false)
                viewRangeMinAmount.isHidden = false
                viewRangeMaxAmount.isHidden = false
            }
        } else {
            btnNoLimits.isHidden = false
            btnFixedAmount.isHidden = false
            btnRangeAmount.isHidden = false
            
        }
        selectedPriceType = index
//        self.tableView.reloadData()
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if selectedPriceType > 0 {
//            return 2
//        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

