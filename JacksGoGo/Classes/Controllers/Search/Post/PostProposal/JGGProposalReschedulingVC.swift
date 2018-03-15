//
//  JGGProposalReschedulingVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGProposalReschedulingVC: JGGPostAppointmentBaseTableVC, UITextFieldDelegate {

    @IBOutlet weak var lblAppointmentTime: UILabel!
    @IBOutlet weak var btnNoAllow: JGGYellowSelectingButton!
    @IBOutlet weak var btnAllow: JGGYellowSelectingButton!
    @IBOutlet weak var txtDay: UITextField!
    @IBOutlet weak var txtHour: UITextField!
    @IBOutlet weak var txtMinutes: UITextField!
    @IBOutlet weak var txtTerms: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblAppointmentTime.text = (parent as? JGGProposalStepRootVC)?.appointment.budgetDescription()
        
        txtDay.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtHour.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtMinutes.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        
        txtDay.delegate = self
        txtHour.delegate = self
        txtMinutes.delegate = self
        txtTerms.delegate = self
        
        showOriginalProposal()
    }
    
    private func showOriginalProposal() {
        let proposal = (self.parent as? JGGProposalStepRootVC)?.proposal
        if let allowed = proposal?.rescheduleAllowed {
            if allowed {
                btnAllow.select(true)
                let totalTime = proposal?.rescheduleTime ?? 0
                let days: Int = Int(totalTime / (3600 * 24))
                let hours: Int = Int((totalTime - Double(days) * 3600 * 24) / 3600)
                let minutes: Int = Int((totalTime - Double(days) * 3600 * 24 - Double(hours) * 3600) / 60)
                txtDay.text = String(days)
                txtHour.text = String(hours)
                txtMinutes.text = String(minutes)
            } else {
                btnNoAllow.select(true)
            }
        } else {
            btnAllow.select(false)
            btnNoAllow.select(false)
        }
        txtTerms.text = proposal?.rescheduleNote
    }
    
    @IBAction func onPressedType(_ sender: UIButton) {
        if let button = sender as? JGGYellowSelectingButton {
            button.select(!button.selected())
            tableView.reloadData()
        }
    }
    
    override func onPressedNext(_ sender: UIButton) {
        if btnAllow.selected() {
            let days  = Int(txtDay.text ?? "0") ?? 0
            let hours = Int(txtHour.text ?? "0") ?? 0
            let minutes = Int(txtMinutes.text ?? "0") ?? 0
            let totalSeconds = (days * 3600 * 24) + (hours * 3600) + (minutes * 60)
            if totalSeconds == 0 {
                Toast(text: LocalizedString("Please enter rescheduling time."), delay: 0, duration: 3).show()
                return
            }
        }
        super.onPressedNext(sender)
    }
    
    override func updateData(_ sender: Any) {
        if let parentVC = parent as? JGGProposalStepRootVC {
            if btnAllow.selected() {
                let days  = Int(txtDay.text ?? "0") ?? 0
                let hours = Int(txtHour.text ?? "0") ?? 0
                let minutes = Int(txtMinutes.text ?? "0") ?? 0
                let totalSeconds = (days * 3600 * 24) + (hours * 3600) + (minutes * 60)
                parentVC.proposal?.rescheduleTime = Double(totalSeconds)
                parentVC.proposal?.rescheduleAllowed = true
                parentVC.proposal?.rescheduleNote = txtTerms.text
            } else {
                if btnNoAllow.selected() {
                    parentVC.proposal?.rescheduleAllowed = false
                } else  {
                    parentVC.proposal?.rescheduleAllowed = nil
                }
                parentVC.proposal?.rescheduleNote = nil
                parentVC.proposal?.rescheduleTime = nil
            }
        }
    }
    
    // MARK: - UITextField delegate
    @objc func textFieldDidChanged(_ textField: UITextField) -> Void {
        guard let text = textField.text else {
            return
        }
        if textField == txtDay {
            let day = Int(text) ?? 0
            if day > 99 {
                textField.text = "99"
            } else if day < 0 {
                textField.text = "0"
            }
            if textField.text!.count >= 2 {
                txtHour.becomeFirstResponder()
            }
        }
        else if textField == txtHour {
            let hours = Int(text) ?? 0
            if hours > 23 {
                textField.text = "23"
            } else if hours < 0 {
                textField.text = "0"
            }
            if textField.text!.count >= 2 {
                txtMinutes.becomeFirstResponder()
            }
        }
        else if textField == txtMinutes {
            let minutes = Int(text) ?? 0
            if minutes > 59 {
                textField.text = "59"
            } else if minutes < 0 {
                textField.text = "0"
            }
            if textField.text!.count >= 2 {
                txtMinutes.resignFirstResponder()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtTerms {
            txtTerms.resignFirstResponder()
        }
        return false
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnNoAllow.selected() {
            return 2
        } else if btnAllow.selected() {
            return 5
        } else {
            return 3
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if btnAllow.selected() && indexPath.row == 1 {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

}
