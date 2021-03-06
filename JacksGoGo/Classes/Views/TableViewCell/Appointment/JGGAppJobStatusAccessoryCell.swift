//
//  JGGAppJobStatusAccessoryCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppJobStatusAccessoryCell: JGGAppJobStatusCell {

    @IBOutlet weak var btnAccessory: UIButton!
    
    var accessoryButtonActionClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onPressedAccessoryButton(_ sender: UIButton) {
        accessoryButtonActionClosure?()
    }
}
