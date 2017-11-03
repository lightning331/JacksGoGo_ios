//
//  JGGDetailInfoHeaderView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGDetailInfoHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var imgviewIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnExpand: UIButton!
    
    var title: String? {
        get {
            return lblTitle.text
        }
        set {
            lblTitle.text = newValue
        }
    }
    
}
