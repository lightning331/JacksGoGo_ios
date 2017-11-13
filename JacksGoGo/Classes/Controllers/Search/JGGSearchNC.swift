//
//  JGGServicesNC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSearchNC: JGGBaseNC {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hidesBarsOnSwipe = true
        
        self.navigationBar.tintColor = UIColor.JGGGreen
        self.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.JGGGreen]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
