//
//  JGGNotLoggedinCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/24/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGNotLoggedinCell: UITableViewCell {

    var loginButtonHandler: VoidClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onPressedLogin(_ sender: UIButton) {
        loginButtonHandler?()
    }
}
