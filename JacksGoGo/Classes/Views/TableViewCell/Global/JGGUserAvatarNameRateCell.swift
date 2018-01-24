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

    @IBOutlet weak var imgviewUserAvatar: JGGCircleImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var ratebarUserRate: CosmosView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
