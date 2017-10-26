//
//  JGGMainTabbarController.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGMainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadViewControllers()
        
        self.selectedIndex = 2
    }
    
    fileprivate func loadViewControllers() {
        if self.viewControllers == nil || self.viewControllers?.count == 0 {
            
            func addChildViewController(storyboardName: String) {
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                if let initialVC = storyboard.instantiateInitialViewController() {
                    self.addChildViewController(initialVC)
                }
            }
            addChildViewController(storyboardName: "Home")
            addChildViewController(storyboardName: "Services")
            addChildViewController(storyboardName: "Appointment")
            addChildViewController(storyboardName: "Favorite")
            addChildViewController(storyboardName: "Profile")
            
        }
    }
    
}
