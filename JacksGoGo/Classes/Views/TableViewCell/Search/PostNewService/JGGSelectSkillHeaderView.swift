//
//  JGGSelectSkillHeaderView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/13/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSelectSkillHeaderView: UICollectionReusableView {

    @IBOutlet weak var viewFirstDescription: UIView!
    @IBOutlet weak var viewSecondDescription: UIView!
    @IBOutlet weak var viewThirdDescription: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewFirstDescription.isHidden = true
        viewSecondDescription.isHidden = true
        viewThirdDescription.isHidden = true
    }
    
}
