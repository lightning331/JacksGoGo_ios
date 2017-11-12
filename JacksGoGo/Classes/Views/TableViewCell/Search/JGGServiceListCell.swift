//
//  JGGServiceListCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos


class JGGServiceListCell: UITableViewCell {

    @IBOutlet weak var imgviewPhoto: UIImageView!
    @IBOutlet weak var lblServiceTitle: UILabel!
    @IBOutlet weak var ratebar: CosmosView!
    @IBOutlet weak var imgviewUserAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblBookedPeople: UILabel!
    @IBOutlet weak var lblViewingNow: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
