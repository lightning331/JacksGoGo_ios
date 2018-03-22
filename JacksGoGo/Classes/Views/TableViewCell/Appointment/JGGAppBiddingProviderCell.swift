//
//  JGGAppBiddingProviderCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 31/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos

class JGGAppBiddingProviderCell: JGGUserAvatarNameRateCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnProposal: UIButton!
    @IBOutlet weak var constraintPriceVerticalCenter: NSLayoutConstraint!
    @IBOutlet weak var btnInvite: UIButton!
    
    var proposal: JGGProposalModel! {
        didSet {
            self.profile = proposal.userProfile!
            showProposalInfo()
        }
    }
    
    var biddingProvider: JGGBiddingProviderModel? {
        didSet {
            updateValue()
        }
    }
    
    var tapProposalHandler:((JGGAppBiddingProviderCell) -> Void)?
    var tapInviteHandler:((JGGAppBiddingProviderCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.btnInvite.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction fileprivate func onPressedProposal(_ sender: UIButton) {
        tapProposalHandler?(self)
    }
    
    @IBAction fileprivate func onPressedInvite(_ sender: UIButton) {
        tapInviteHandler?(self)
    }

    
    fileprivate func showProposalInfo() {
        
        self.lblPrice.text = proposal.budgetDescription()
        
        self.viewBackground.backgroundColor = UIColor.JGGWhite
        switch proposal.status {
        case .open:
            self.lblStatus.isHidden = true
            self.viewBackground.alpha = 1.0
            self.constraintPriceVerticalCenter.constant = 0
            break
        case .confirmed:
            self.lblStatus.isHidden = true
            self.viewBackground.alpha = 1.0
            self.viewBackground.backgroundColor = UIColor.JGGGreen10Percent
            self.constraintPriceVerticalCenter.constant = 0
            break
        case .rejected:
            self.lblStatus.isHidden = false
            self.lblStatus.text = LocalizedString("Rejected")
            self.viewBackground.alpha = 0.5
            self.constraintPriceVerticalCenter.constant = -10
            break
        case .withdrawed:
            self.lblStatus.isHidden = false
            self.lblStatus.text = LocalizedString("Withdrawed")
            self.viewBackground.alpha = 0.5
            self.constraintPriceVerticalCenter.constant = -10
            break
        }
    }
    
    fileprivate func updateValue() {
        if let biddingProvider = self.biddingProvider {
            self.lblUsername.text = biddingProvider.user.fullname
            self.ratebarUserRate.rating = biddingProvider.user.rate
            self.viewBackground.backgroundColor = biddingProvider.isNew ? UIColor.JGGGreen10Percent : UIColor.JGGWhite
            switch biddingProvider.status {
            case .pending:
                self.lblPrice.text = biddingProvider.price.formattedPriceString()
                self.lblStatus.text = nil
                self.btnProposal.isHidden = false
                self.viewBackground.alpha = 1.0
                self.constraintPriceVerticalCenter.constant = 0
                updateConstraints()
                break
            case .notResponded:
                self.lblPrice.text = nil
                self.lblStatus.text = nil
                self.btnProposal.isHidden = true
                self.viewBackground.alpha = 1.0
                break
            case .declined:
                self.lblPrice.text = nil
                self.lblStatus.text = "Declined"
                self.btnProposal.isHidden = true
                self.viewBackground.alpha = 0.5
                self.constraintPriceVerticalCenter.constant = -10
                updateConstraints()
                break
            case .rejected:
                self.lblPrice.text = biddingProvider.price.formattedPriceString()
                self.lblStatus.text = "Rejected"
                self.btnProposal.isHidden = false
                self.viewBackground.alpha = 0.5
                self.constraintPriceVerticalCenter.constant = -6
                updateConstraints()
                break
            case .accepted:
                self.contentView.backgroundColor = UIColor.JGGRed10Percecnt
                self.lblPrice.text = biddingProvider.price.formattedPriceString()
                self.lblStatus.text = nil
                self.btnProposal.isHidden = true
                self.viewBackground.alpha = 1.0
                self.constraintPriceVerticalCenter.constant = 0
                updateConstraints()
                break
            }
            if biddingProvider.status == .pending {
            }
        }
    }
}
