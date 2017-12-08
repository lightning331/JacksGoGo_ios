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
    @IBOutlet weak var imgviewFavorite: UIImageView!
    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblServiceTitle: UILabel!
    @IBOutlet weak var ratebar: CosmosView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblBookedPeople: UILabel!

    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewRatebar: UIView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewPrice: UIView!
    @IBOutlet weak var viewBooked: UIView!
    
    @IBOutlet weak var imgviewAccessory: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
