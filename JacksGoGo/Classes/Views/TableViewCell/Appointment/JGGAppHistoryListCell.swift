//
//  JGGAppHistoryListCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppHistoryListCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var viewRightSideBadge: UIView!
    @IBOutlet weak var imgviewAvatar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewCountBadge: UIView!
    @IBOutlet weak var lblCountBadge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
