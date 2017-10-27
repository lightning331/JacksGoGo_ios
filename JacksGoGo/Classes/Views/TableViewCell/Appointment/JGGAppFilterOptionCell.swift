//
//  JGGAppFilterOptionCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 27/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppFilterOptionCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            self.viewBackground.backgroundColor = UIColor.clear
            self.viewBackground.borderColor = UIColor.JGGRed
            self.viewBackground.borderWidth = 2
            self.lblTitle.textColor = UIColor.JGGRed;
        } else {
            self.viewBackground.backgroundColor = UIColor.JGGYellow
            self.viewBackground.borderColor = UIColor.clear
            self.viewBackground.borderWidth = 0
            self.lblTitle.textColor = UIColor.JGGBlack;
        }
    }

}
