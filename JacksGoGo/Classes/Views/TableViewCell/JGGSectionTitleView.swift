//
//  JGGSectionTitleView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSectionTitleView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
}
