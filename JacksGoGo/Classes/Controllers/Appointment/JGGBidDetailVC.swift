//
//  JGGBidDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGBidDetailVC: JGGProposalOverviewVC {

    @IBOutlet weak var btnRejectBid: UIButton!
    @IBOutlet weak var btnAcceptBid: UIButton!
    @IBOutlet weak var constraintLeftPaddingOfAccentBidButton: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        constraintLeftPaddingOfAccentBidButton.constant = self.view.frame.width * 0.5
        
    }
    
    @IBAction func onPressedRejectBid(_ sender: Any) {
        JGGAlertViewController.show(title: LocalizedString("Reject this bid?"),
                                    message: nil,
                                    colorSchema: .green,
                                    okButtonTitle: LocalizedString("Reject"),
                                    okAction: { text in
            
        },
                                    cancelButtonTitle: LocalizedString("Cancel"),
                                    cancelAction: nil)
    }
    
    @IBAction func onPressedAcceptBid(_ sender: Any) {
        JGGActionSheet.showInteraction(title: LocalizedString("Choose a package:"),
                                       primaryButtonTitle: LocalizedString("One-Time:") + " $ 100.00",
                                       secondaryButtonTitle: LocalizedString("Package:") + " $ 800.00 for 10",
                                       cancelButtonTitle: LocalizedString("Cancel"),
                                       primaryButtonAction: {
            
        }, secondaryButtonAction: {
            
        }, cancelButtonAction: nil)
    }
    
}
