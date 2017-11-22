//
//  JGGUserReviewCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/21/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos

class JGGUserReviewCell: UITableViewCell {

    @IBOutlet weak var imgviewUserAvatar: JGGCircleImageView!
    @IBOutlet weak var lblUsernameDate: UILabel!
    @IBOutlet weak var ratebar: CosmosView!
    @IBOutlet weak var lblReview: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
