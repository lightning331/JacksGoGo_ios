//
//  JGGPostServiceTimeSlotsBaseVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/20/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceTimeSlotsBaseVC: JGGPostAppointmentBaseTableVC {

    internal var navController: JGGPostServiceTimeSlotsNC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navController = self.navigationController as! JGGPostServiceTimeSlotsNC
    }

}
