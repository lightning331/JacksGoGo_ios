//
//  JGGHomeMainVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/24/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import Crashlytics

class JGGHomeMainVC: JGGStartTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func showLoginVCIfNeed() -> Bool {
        return false
    }

    @IBAction func onPressedCrash(_ sender: UIButton) {
        Crashlytics.sharedInstance().crash()
    }
    
    // MARK: - Table view data source

}
