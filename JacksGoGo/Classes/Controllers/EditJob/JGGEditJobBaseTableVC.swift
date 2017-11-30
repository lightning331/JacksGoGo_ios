//
//  JGGEditJobBaseTableVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGEditJobBaseTableVC: JGGTableViewController {

    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor.JGGGrey5

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let parentVC = parent as? JGGEditJobStepRootVC,
            parentVC.isRequestQuotationMode == false {
            self.tableView.tableFooterView = nil
        }
    }

    @IBAction func onPressedNext(_ sender: UIButton) {
        if let parentVC = parent as? JGGEditJobStepRootVC {
            parentVC.editJobStepView.completeCurrentStep()
            parentVC.editJobStepView.nextStep()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
