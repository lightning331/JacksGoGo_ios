//
//  JGGProposalSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/13/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import MBProgressHUD

class JGGProposalSummaryVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var lblDescribe: UILabel!
    
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnRescheduling: UIButton!
    @IBOutlet weak var lblRescheduling: UILabel!
    
    @IBOutlet weak var btnCancellation: UIButton!
    @IBOutlet weak var lblCancellation: UILabel!

    var appointment: JGGJobModel!
    var proposal: JGGProposalModel!
    var isEditMode: Bool = false
    
    private var hud: MBProgressHUD!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if isEditMode {
            self.btnNext.setTitle(LocalizedString("Delete Proposal And Remove Bid"), for: .normal)
        } else {
            self.btnNext.setTitle(LocalizedString("Submit Proposal"), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lblDescribe.text = proposal.description_
        lblDescribe.font = UIFont.JGGListText
        
        lblPrice.text = String(format: "$ %.2f", proposal.budget ?? 0)
        lblPrice.font = UIFont.JGGListTitle
        
        lblRescheduling.text = proposal.rescheduleTimeDescription()
        lblRescheduling.font = UIFont.JGGListText
        
        lblCancellation.text = proposal.cancellationTimeDescription()
        lblCancellation.font = UIFont.JGGListText

        if isEditMode {
            NotificationCenter.default.addObserver(self, selector: #selector(onPressedSave(_:)), name: NotificationEditProposalSave, object: nil)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isEditMode {
            NotificationCenter.default.removeObserver(self, name: NotificationEditProposalSave, object: nil)
        }
    }
    
    @objc func onPressedSave(_ sender: Any) {
        
        JGGAlertViewController.show(title: LocalizedString("Proposal Sent!"),
                                    message: String(format: LocalizedString("Proposal reference no.: %@"), proposal.id ?? ""),
                                    colorSchema: .cyan,
                                    okButtonTitle: LocalizedString("View Proposal"),
                                    okAction: { text in
                                        self.navigationController?.parent?.navigationController?.popViewController(animated: true)
        },
                                    cancelButtonTitle: nil,
                                    cancelAction: nil)

        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    @IBAction func onPressedStep(_ sender: UIButton) {
        if let stepRootVC = self.navigationController?.viewControllers.first as? JGGProposalStepRootVC {
            var index: Int = 0
            if sender == btnDescribe {
                index = 0
            }
            else if sender == btnPrice {
                index = 1
            }
            else if sender == btnRescheduling {
                index = 2
            }
            else if sender == btnCancellation {
                index = 3
            }
            stepRootVC.stepView.selectStep(index: index)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPressedPostNewJob(_ sender: UIButton) {
        
        if isEditMode {
            
            JGGAlertViewController.show(title: LocalizedString("Delete Proposal And Remove Bid?"),
                                        message: LocalizedString("This action cannot be undo."),
                                        colorSchema: .red,
                                        cancelColorSchema: .cyan,
                                        okButtonTitle: LocalizedString("Delete"),
                                        okAction: { text in
                                            
                                            
            },
                                        cancelButtonTitle: LocalizedString("Cancel"),
                                        cancelAction: nil)

            
        } else {
            submitProposal(proposal)
        }
    
    }
    
    private func submitProposal(_ proposal: JGGProposalModel) {
        hud = MBProgressHUD.showAdded(to: self.parent!.parent!.parent!.view, animated: true)
        hud.mode = .indeterminate
        APIManager.postProposal(proposal, user: proposal.userProfile!) { (proposalId, errorMessage) in
            self.hud.hide(animated: true)
            
        }
    }
}
