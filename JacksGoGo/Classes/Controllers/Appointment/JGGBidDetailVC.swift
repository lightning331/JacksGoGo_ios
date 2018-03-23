//
//  JGGBidDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MBProgressHUD

class JGGBidDetailVC: JGGProposalOverviewVC {

    @IBOutlet weak var btnRejectBid: UIButton!
    @IBOutlet weak var btnAcceptBid: UIButton!
    @IBOutlet weak var constraintLeftPaddingOfAccentBidButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        constraintLeftPaddingOfAccentBidButton.constant = self.view.frame.width * 0.5
        
    }
    
    @IBAction func onPressedRejectBid(_ sender: Any) {
        JGGAlertViewController.show(
            title: LocalizedString("Reject this bid?"),
            message: nil,
            colorSchema: .green,
            okButtonTitle: LocalizedString("Reject"),
            okAction: { text in
                self.rejectProposal()
            },
            cancelButtonTitle: LocalizedString("Cancel"),
            cancelAction: nil)
    }
    
    @IBAction func onPressedAcceptBid(_ sender: Any) {
        JGGActionSheet.showInteraction(
            title: LocalizedString("Choose a package:"),
            primaryButtonTitle: LocalizedString("One-Time:") + " $ 100.00",
            secondaryButtonTitle: LocalizedString("Package:") + " $ 800.00 for 10",
            cancelButtonTitle: LocalizedString("Cancel"),
            primaryButtonAction: {
                
            },
            secondaryButtonAction: {
            
            },
            cancelButtonAction: nil
        )
    }
    
    private func rejectProposal() {
        let hud = MBProgressHUD.showAdded(to: self.navigationController!.view, animated: true)
        APIManager.rejectProposal(id: self.proposal.id!) { (success, errorMessge) in
            hud.hide(animated: true)
            if !success {
                JGGAlertViewController.show(
                    title: LocalizedString("Error"),
                    message: errorMessge,
                    colorSchema: .red,
                    okButtonTitle: LocalizedString("Close"),
                    okAction: { (text) in
                    
                    },
                    cancelButtonTitle: nil,
                    cancelAction: nil
                )
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
            if segueId == "gotoAcceptBid" {
                let acceptBidVC = segue.destination as! JGGAcceptBidVC
                acceptBidVC.proposal = self.proposal
                acceptBidVC.selectedAppointment = self.selectedAppointment
            }
        }
    }
    
}
