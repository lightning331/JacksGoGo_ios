//
//  JGGPostJobReportVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/29/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostJobReportVC: JGGEditJobReportVC {

    override func viewDidLoad() {
        defaultColor = UIColor.JGGCyan
        super.viewDidLoad()
    }
    
    override func onPressedNext(_ sender: UIButton) {
        if let parentVC = parent as? JGGPostJobStepRootVC {
            parentVC.gotoSummaryVC()
        }
    }

}
