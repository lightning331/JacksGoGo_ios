//
//  JGGPostAppointmentBaseTableVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostAppointmentBaseTableVC: JGGTableViewController {

    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.JGGGrey5
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let parentVC = parent as? JGGPostServiceStepRootVC,
            parentVC.isEditMode == false {
//            self.tableView.tableFooterView = nil
        }
    }
    
    @IBAction func onPressedNext(_ sender: UIButton) {
        if let parentVC = parent as? JGGPostServiceStepRootVC {
            parentVC.postServiceStepView.completeCurrentStep()
            parentVC.postServiceStepView.nextStep()
        } else if let parentVC = parent as? JGGPostJobStepRootVC {
            parentVC.postJobStepView.completeCurrentStep()
            parentVC.postJobStepView.nextStep()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

}
