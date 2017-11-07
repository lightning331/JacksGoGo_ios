//
//  JGGTotalReviewCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos

class JGGTotalReviewCell: UITableViewCell {

    @IBOutlet weak var ratebarTotalReviews: CosmosView!
    @IBOutlet weak var btnSeeAllReviews: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
