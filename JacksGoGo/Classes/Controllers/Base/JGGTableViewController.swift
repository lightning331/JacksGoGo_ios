//
//  JGGTableViewController.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.JGGGrey4
        refreshControl.tintColor = UIColor.JGGBlack
        refreshControl.addTarget(
            self,
            action: #selector(pullToRefresh(_:)),
            for: .valueChanged
        )
        self.refreshControl = refreshControl
    }
    
    @objc internal func pullToRefresh(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

}
