//
//  JGGStartTableVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGStartTableVC: JGGTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.changeTabBar(hidden: true, animated: true)
        }
        else{
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
}
