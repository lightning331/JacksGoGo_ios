//
//  JGGAppMainVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppMainVC: JGGStartTableVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        initializeTableView()
        addSearchField()
        registerCell()
        
    }
        
    private func initializeTableView() {
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 55
    }

    private func addSearchField() {
        let searchfieldView =
            UINib(nibName: "JGGAppSearchHeaderView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as? JGGAppSearchHeaderView
        self.tableView.tableHeaderView = searchfieldView
        
    }
    
    private func registerCell() {
        self.tableView.register(UINib(nibName: "JGGAppHistoryListCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppHistoryListCell")
        self.tableView.register(UINib(nibName: "JGGSectionTitleView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "JGGSectionTitleView")
    }
    
    // MARK: - UITableView Data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGSectionTitleView") as? JGGSectionTitleView
        if section == 0 {
            sectionTitleView?.title = "Quick Jobs"
        }
        else if section == 1 {
            sectionTitleView?.title = "Service Packages"
        }
        else if section == 2 {
            sectionTitleView?.title = "Pending Jobs"
        }
        return sectionTitleView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return 1
        }
        else if section == 2 {
            return 10
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppHistoryListCell") as! JGGAppHistoryListCell
        
        return cell
    }
    
}
