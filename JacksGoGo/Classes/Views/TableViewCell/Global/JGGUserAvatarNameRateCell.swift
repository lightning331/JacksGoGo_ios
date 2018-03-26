//
//  JGGUserAvatarNameRateCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos

class JGGUserAvatarNameRateCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imgviewUserAvatar: JGGCircleImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var ratebarUserRate: CosmosView!

    var profile: JGGUserProfileModel! {
        didSet {
            self.showUserProfileInfo()
        }
    }
    
    var tapProfileHandler: ((JGGUserAvatarNameRateCell) -> Void)? {
        didSet {
            if let _ = tapProfileHandler {
                imgviewUserAvatar.isUserInteractionEnabled = true
            } else {
                imgviewUserAvatar.isUserInteractionEnabled = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapUserProfile = UITapGestureRecognizer(target: self, action: #selector(onPressedUserProfile(_:)))
        imgviewUserAvatar.addGestureRecognizer(tapUserProfile)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc internal func onPressedUserProfile(_ sender: Any) {
        tapProfileHandler?(self)
    }

    internal func showUserProfileInfo() {
        
        let user = profile.user
        self.lblUsername.text = user?.fullname ?? user?.email
        self.ratebarUserRate.rating = user?.rate ?? 0
        let placeholderAvatar = UIImage(named: "icon_Profile")
        if let urlString = user?.photoURL, let url = URL(string: urlString) {
            imgviewUserAvatar.af_setImage(withURL: url, placeholderImage: placeholderAvatar)
        } else {
            imgviewUserAvatar.image = placeholderAvatar
        }
        self.viewBackground.backgroundColor = UIColor.JGGWhite
    }

}
