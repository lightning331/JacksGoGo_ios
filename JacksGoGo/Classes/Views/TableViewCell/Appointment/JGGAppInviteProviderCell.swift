//
//  JGGAppInviteProviderCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppInviteProviderCell: JGGUserAvatarNameRateCell {

    @IBOutlet weak var btnInvite: UIButton!
    
    var user: JGGProviderUserModel? {
        didSet {
            showUserInformation()
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
    
    fileprivate func showUserInformation() {
        if let user = user {
            self.lblUsername.text = user.fullname
            self.ratebarUserRate.rating = user.rate
        }
    }
    
}
