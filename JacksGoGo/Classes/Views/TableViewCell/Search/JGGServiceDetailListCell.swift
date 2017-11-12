//
//  JGGServiceDetailListCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos

class JGGServiceDetailListCell: UITableViewCell {

    @IBOutlet weak var imgviewPhoto: UIImageView!
    @IBOutlet weak var lblServiceTitle: UILabel!
    @IBOutlet weak var ratebar: CosmosView!
    @IBOutlet weak var imgviewUserAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imgviewShadow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgviewShadow.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
