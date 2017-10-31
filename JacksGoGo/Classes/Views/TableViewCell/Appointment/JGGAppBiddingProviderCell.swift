//
//  JGGAppBiddingProviderCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 31/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos

class JGGAppBiddingProviderCell: UITableViewCell {

    @IBOutlet weak var imgviewUserAvatar: JGGCircleImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var ratebarUserRate: CosmosView!
    @IBOutlet weak var lblPriceAndStatus: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgviewNoteBadge: UIImageView!
    @IBOutlet weak var constraintPriceVerticalCenter: NSLayoutConstraint!
    
    var biddingProvider: JGGBiddingProviderModel? {
        didSet {
            updateValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    fileprivate func updateValue() {
        if let biddingProvider = self.biddingProvider {
            self.lblUsername.text = biddingProvider.user.fullname
            self.ratebarUserRate.rating = biddingProvider.user.rate
            self.contentView.backgroundColor = biddingProvider.isNew ? UIColor.JGGGreen10Percent : UIColor.JGGWhite
            switch biddingProvider.status {
            case .pending:
                self.lblPriceAndStatus.text = biddingProvider.price.formattedPriceString()
                self.lblStatus.text = nil
                self.imgviewNoteBadge.isHidden = false
                self.contentView.alpha = 1.0
                self.constraintPriceVerticalCenter.constant = 0
                updateConstraints()
                break
            case .notResponded:
                self.lblPriceAndStatus.text = nil
                self.lblStatus.text = nil
                self.imgviewNoteBadge.isHidden = true
                self.contentView.alpha = 1.0
                break
            case .declined:
                self.lblPriceAndStatus.text = nil
                self.lblStatus.text = "Declined"
                self.imgviewNoteBadge.isHidden = true
                self.contentView.alpha = 0.5
                self.constraintPriceVerticalCenter.constant = -10
                updateConstraints()
                break
            case .rejected:
                self.lblPriceAndStatus.text = biddingProvider.price.formattedPriceString()
                self.lblStatus.text = "Rejected"
                self.imgviewNoteBadge.isHidden = false
                self.contentView.alpha = 0.5
                self.constraintPriceVerticalCenter.constant = -6
                updateConstraints()
                break
            case .accepted:
                self.contentView.backgroundColor = UIColor.JGGRed10Percecnt
                self.lblPriceAndStatus.text = biddingProvider.price.formattedPriceString()
                self.lblStatus.text = nil
                self.imgviewNoteBadge.isHidden = true
                self.contentView.alpha = 1.0
                self.constraintPriceVerticalCenter.constant = 0
                updateConstraints()
                break
            }
            if biddingProvider.status == .pending {
            }
        }
    }
}
