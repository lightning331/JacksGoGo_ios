//
//  JGGDetailCategoryTitleCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGDetailCategoryTitleCell: UITableViewCell {

    @IBOutlet weak var imgviewIcon: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    var title: String? {
        get {
            return lblTitle.text
        }
        set {
            lblTitle.text = newValue
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
    
}
