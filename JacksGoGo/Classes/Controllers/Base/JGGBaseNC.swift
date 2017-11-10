//
//  JGGBaseNC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGBaseNC: UINavigationController {

    var tag: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hidesBarsOnSwipe = true
        self.navigationBar.barTintColor = UIColor.JGGWhite
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
