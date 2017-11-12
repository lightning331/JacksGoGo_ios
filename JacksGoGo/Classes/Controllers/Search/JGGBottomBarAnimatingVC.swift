//
//  JGGBottomBarAnimatingVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGBottomBarAnimatingVC: JGGServicesBaseVC {

    @IBOutlet weak var constraintBottomSpaceOfBottomView: NSLayoutConstraint?
    @IBOutlet weak var tableView: UITableView?
    
    fileprivate var isShowBottomBar: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension JGGBottomBarAnimatingVC: UITableViewDataSource, UITableViewDelegate {
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.changeTabBar(hidden: true, animated: true)
        }
        else{
            self.changeTabBar(hidden: false, animated: true)
        }
    }
    
    private func changeTabBar(hidden: Bool, animated: Bool) {
        if let constraint = self.constraintBottomSpaceOfBottomView {
            if (!hidden && isShowBottomBar) || (hidden && !isShowBottomBar) {
                return
            }
            isShowBottomBar = !hidden
            if hidden {
                constraint.constant = -50
            } else {
                constraint.constant = 0
            }
            updateConstraint()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
