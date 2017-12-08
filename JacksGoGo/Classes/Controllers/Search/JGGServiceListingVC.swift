//
//  JGGServiceListingVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGServiceListingVC: JGGSearchBaseVC, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var constraintBottomSpaceOfBottomView: NSLayoutConstraint?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var btnPostNewService: UIButton!

    fileprivate var isShowBottomBar: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        
    }

    private func initTableView() {
        self.tableView?.register(UINib(nibName: "JGGCategoryDetailHeaderView", bundle: nil),
                                 forHeaderFooterViewReuseIdentifier: "JGGCategoryDetailHeaderView")
        self.tableView?.register(UINib(nibName: "JGGServiceListCell", bundle: nil),
                                 forCellReuseIdentifier: "JGGServiceListCell")
        
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.separatorStyle = .none
        self.tableView?.allowsSelection = true

    }

    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGCategoryDetailHeaderView") as! JGGCategoryDetailHeaderView
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGServiceListCell") as! JGGServiceListCell
        
        return cell
    }
    
    // MARK: ScrollView delegate
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
                constraint.constant = 50
            } else {
                constraint.constant = 0
            }
            updateConstraint()
        }
    }

}
