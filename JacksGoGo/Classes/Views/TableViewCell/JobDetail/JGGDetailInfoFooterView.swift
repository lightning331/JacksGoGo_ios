//
//  JGGDetailInfoFooterView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGDetailInfoFooterView: UIView {

    @IBOutlet weak var lblText: UILabel!
    
    var text: String? {
        get {
            return lblText.text
        }
        set {
            lblText.text = newValue
        }
    }

}
