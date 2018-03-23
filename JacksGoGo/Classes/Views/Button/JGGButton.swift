//
//  JGGButton.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGButton: UIButton {

    func enable(with color: UIColor?) {
        self.backgroundColor = color
        isEnabled = true
    }
    
    func disable() {
        self.backgroundColor = UIColor.JGGGrey4
        isEnabled = false
    }
    
}
