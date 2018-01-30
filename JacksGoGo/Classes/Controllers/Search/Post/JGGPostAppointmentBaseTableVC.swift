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
        NotificationCenter.default.addObserver(self, selector: #selector(updateData(_:)), name: NSNotification.Name(rawValue: "UpdateData"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UpdateData"), object: nil)
    }
    
    @IBAction func onPressedNext(_ sender: UIButton) {
        updateData(self)
        if let parentVC = parent as? JGGPostStepRootBaseVC {
            parentVC.stepView.completeCurrentStep()
            parentVC.stepView.nextStep()
        }
    }
    
    @objc internal func updateData(_ sender: Any) {
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

}
