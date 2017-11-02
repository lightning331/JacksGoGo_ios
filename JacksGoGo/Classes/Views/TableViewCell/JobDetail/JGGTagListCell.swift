//
//  JGGTagListCell.swift
//  JacksGoGo
//
//  Created by Chris Lin on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import TagListView

class JGGTagListCell: UITableViewCell {

    @IBOutlet weak var taglistView: TagListView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
