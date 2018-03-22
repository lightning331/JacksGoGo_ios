//
//  JGGPrivateProfileVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/23/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPrivateProfileVC: JGGProfileSummaryVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

}
