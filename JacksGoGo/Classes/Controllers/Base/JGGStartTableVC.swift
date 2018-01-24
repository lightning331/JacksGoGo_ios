//
//  JGGStartTableVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGStartTableVC: JGGTableViewController {
    
    internal var isLoggedIn: Bool = false
    internal var isPromptedLoginVC: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        if let _ = appManager.currentUser {
            isLoggedIn = true
        }
        
        self.tableView.register(UINib(nibName: "JGGNotLoggedinCell", bundle: nil),
                                forCellReuseIdentifier: "JGGNotLoggedinCell")
    }
    
    internal func showLoginVCIfNeed() -> Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isPromptedLoginVC && !isLoggedIn && showLoginVCIfNeed() {
            isPromptedLoginVC = true
            presentLoginVC()
        }
    }
    
    
    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.changeTabBar(hidden: true, animated: true)
        }
        else {
            self.changeTabBar(hidden: false, animated: true)
        }
    }
    
    private func changeTabBar(hidden: Bool, animated: Bool){
        if let tabBar = self.tabBarController?.tabBar {
            if tabBar.isHidden == hidden { return }
            let frame = tabBar.frame
            let offset = (hidden ? (frame.size.height) : -(frame.size.height))
            let duration: TimeInterval = (animated ? 0.2 : 0.0)
            tabBar.isHidden = false
            UIView.animate(withDuration: duration,
                           animations: { tabBar.frame = frame.offsetBy(dx: 0, dy: offset) },
                           completion: { if $0 {tabBar.isHidden = hidden}})
            
        }
    }
    
    internal func presentLoginVC() {
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        if let profileNC = profileStoryboard.instantiateInitialViewController() as? JGGProfileNC {
            profileNC.shouldDismiss = true
            self.navigationController?.tabBarController?.present(profileNC, animated: true, completion: nil)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !isLoggedIn {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGNotLoggedinCell") as! JGGNotLoggedinCell
            cell.loginButtonHandler = {
                self.presentLoginVC()
            }
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
