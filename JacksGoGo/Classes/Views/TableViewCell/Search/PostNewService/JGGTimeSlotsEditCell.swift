//
//  JGGTimeSlotsEditCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGTimeSlotsEditCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var editTimeHandler: ((JGGTimeSlotsEditCell) -> Void)!
    var deleteTimeHandler: ((JGGTimeSlotsEditCell) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onPressedEdit(_ sender: UIButton) {
        editTimeHandler(self)
    }
    
    @IBAction func onPressedDelete(_ sender: UIButton) {
        deleteTimeHandler(self)
    }
    
}
