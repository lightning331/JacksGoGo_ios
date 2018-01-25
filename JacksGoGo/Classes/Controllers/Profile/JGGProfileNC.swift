//
//  JGGProfileNC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProfileNC: JGGBaseNC {

    var selectedRegion: JGGRegionModel?
    var shouldDismiss: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        
        if let _ = appManager.currentUser {
            loggedIn()
        } else {
            loggedOut()
        }
        
        addLogInOutNotifications()
    }

    override func loggedInHandler(_ sender: Any) {
        loggedIn()
    }
    
    override func loggedOutHandler(_ sender: Any) {
        loggedOut()
    }
    
    func loggedIn() -> Void {
        if shouldDismiss {
            self.dismiss(animated: true, completion: nil)
        } else {
            let profileMainVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGProfileMainVC") as! JGGProfileMainVC
            self.viewControllers = [profileMainVC]
        }
    }
    
    func loggedOut() -> Void {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGLoginVC") as! JGGLoginVC
        self.viewControllers = [loginVC]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
