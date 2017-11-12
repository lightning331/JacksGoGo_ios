//
//  JGGServiceListingVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGServiceListingVC: JGGBottomBarAnimatingVC {

    @IBOutlet weak var btnPostNewService: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        
    }

    private func initTableView() {
        self.tableView?.register(UINib(nibName: "JGGCategoryDetailHeaderView", bundle: nil),
                                 forHeaderFooterViewReuseIdentifier: "JGGCategoryDetailHeaderView")
        self.tableView?.register(UINib(nibName: "JGGServiceDetailListCell", bundle: nil),
                                 forCellReuseIdentifier: "JGGServiceDetailListCell")
        
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.separatorStyle = .none
        self.tableView?.allowsSelection = true

    }

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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGServiceDetailListCell") as! JGGServiceDetailListCell
        if indexPath.row == 0 {
            cell.imgviewShadow.isHidden = false
        } else {
            cell.imgviewShadow.isHidden = true
        }
        return cell
    }
}
