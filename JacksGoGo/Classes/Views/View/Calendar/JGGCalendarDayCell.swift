//
//  JGGCalendarDayCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/21/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import JTAppleCalendar

class JGGCalendarDayCell: JTAppleCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewCirlceBorder: UIView!
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var viewGreenDot: UIView!
    
    var color: UIColor? {
        set {
            viewCirlceBorder.borderColor = newValue
            viewGreenDot.backgroundColor = newValue
        }
        get {
            return viewCirlceBorder.borderColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
