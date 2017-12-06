//
//  JGGYellowSelectingButton.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGYellowSelectingButton: JGGButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var _isSelected: Bool = false
        
    func select(_ select: Bool) -> Void {
        _isSelected = select
        if _isSelected {
            setTitleColor(UIColor.JGGBlack, for: .normal)
            backgroundColor = UIColor.JGGYellow
            borderColor = nil
            borderWidth = 0
        } else {
            setTitleColor(UIColor.JGGGreen, for: .normal)
            backgroundColor = UIColor.clear
            borderColor = UIColor.JGGGreen
            borderWidth = 1
        }
    }
    
    func selected() -> Bool {
        return _isSelected
    }
    
}
