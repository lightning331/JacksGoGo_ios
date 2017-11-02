//
//  JGGBorderButtonCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGBorderButtonCell: UITableViewCell {

    @IBOutlet weak var btnPrimary: UIButton!
    
    var buttonTitle: String? {
        get {
            return btnPrimary.title(for: .normal)
        }
        set {
            btnPrimary.setTitle(newValue, for: .normal)
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
