//
//  JGGMainStartNC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGMainStartNC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hidesBarsOnSwipe = true
        self.hidesBarsWhenKeyboardAppears = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !checkLoggedin() {
            openLoginController()
            
        } else {
            loadMainController()
            
        }
    }
    
    fileprivate func checkLoggedin() -> Bool {
        
        return true
        
    }

    fileprivate func openLoginController() {
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        if let loginVC = loginStoryboard.instantiateInitialViewController() {
            self.present(loginVC, animated: true, completion: nil)
        } else {
            print("There is no Login instantiate initial view controller. Please check Login.storyboard initial view controller.");
        }
    }
    
    fileprivate func loadMainController() {
        if self.viewControllers.count == 0 {
            if let mainTabVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGMainTabbarController") {
                self.viewControllers = [mainTabVC]
            } else {
                print("There is no Main Tabbar Controller. Please check JGGMainTabbarController in Main.storyboard.");
            }
        }
    }
    
    func logout() -> Void {
        self.viewControllers.removeAll()
        openLoginController()
    }
}
