//
//  JGGProposalBidVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGProposalBidVC: JGGPostAppointmentBaseTableVC, UITextFieldDelegate {

    @IBOutlet weak var lblAppointmentPrice: UILabel!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtBreakdown: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtPrice.delegate = self
        txtBreakdown.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let job = (self.parent as? JGGProposalStepRootVC)?.appointment
        lblAppointmentPrice.text = job?.budgetDescription()
        
        if job?.budgetType == 2 || job?.budgetType == 1 {
            txtPrice.placeholder = LocalizedString("Bid Amount  $ 1.00")
        } else {
            txtPrice.placeholder = LocalizedString("Bid Amount  $ 1.00/month")
        }
        showOriginalProposal()
    }
    
    private func showOriginalProposal() {
        let proposal = (self.parent as? JGGProposalStepRootVC)?.proposal
        let job = (self.parent as? JGGProposalStepRootVC)?.appointment
        if job?.budgetType == 2 || job?.budgetType == 1 {
            txtPrice.text = String(format: "$ %.2f", (proposal?.budget ?? 0))
        } else {
            txtPrice.text = String(format: "$ %.2f%@", (proposal?.budget ?? 0), LocalizedString("/month"))
        }
        txtBreakdown.text = proposal?.breakdown
    }

    override func onPressedNext(_ sender: UIButton) {
        guard let priceString = txtPrice.text else {
            Toast(text: LocalizedString("Please enter your price"), delay: 0, duration: 3).show()
            return
        }
        
        if doubleValue(from: priceString) > 0 {
            super.onPressedNext(sender)
        } else {
            Toast(text: LocalizedString("Please enter at least $0.00"), delay: 0, duration: 3).show()
        }
        
    }
    
    override func updateData(_ sender: Any) {
        self.view.endEditing(true)
        if let parentVC = self.parent as? JGGProposalStepRootVC {
            parentVC.proposal?.budget = doubleValue(from: txtPrice.text!)
            parentVC.proposal?.breakdown = txtBreakdown.text
        }
    }

    // MARK: - UITextField delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return true
        }
        if textField == txtPrice {
            let value = doubleValue(from: text)
            if value == 0 {
                textField.text = ""
            } else {
                textField.text = String(format: "%.2f", value)
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtPrice {
            if let text = textField.text {
                let value = doubleValue(from: text)
                if value == 0 {
                    textField.text = ""
                } else {
                    let job = (self.parent as? JGGProposalStepRootVC)?.appointment
                    if job?.budgetType == 2 || job?.budgetType == 1 {
                        textField.text = String(format: "$ %.2f", value)
                    } else {
                        textField.text = String(format: "$ %.2f%@", value, LocalizedString("/month"))
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtPrice {
            txtBreakdown.becomeFirstResponder()
        } else if textField == txtBreakdown {
            txtBreakdown.resignFirstResponder()
        }
        return false
    }
    
    private func doubleValue(from text: String) -> Double {
        var startIndex: String.Index = text.startIndex
        var endIndex: String.Index = text.endIndex
        if let _ = text.range(of: "$") {
            startIndex = text.index(text.startIndex, offsetBy: 2)
        }
        let unitString = LocalizedString("/month")
        if let _ = text.range(of: unitString) {
            endIndex = text.index(text.endIndex, offsetBy: -unitString.count)
        }
        let range = startIndex ..< endIndex
        let valueString = text[range]
        print(valueString)
        
        return Double(String(valueString)) ?? 0
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
