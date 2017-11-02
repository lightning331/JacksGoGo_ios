//
//  JGGDetailInfoAccessoryButtonCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGDetailInfoAccessoryButtonCell: JGGDetailInfoDescriptionCell {

    @IBOutlet weak var btnAccessory: UIButton!
    
    var buttonImage: UIImage? {
        get {
            return btnAccessory.image(for: .normal)
        }
        set {
            btnAccessory.setImage(newValue, for: .normal)
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
