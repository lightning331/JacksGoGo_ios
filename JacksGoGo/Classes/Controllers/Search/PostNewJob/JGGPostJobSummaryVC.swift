//
//  JGGJobSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/29/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import TagListView

class JGGPostJobSummaryVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobDescribe: UILabel!
    @IBOutlet weak var tagview: TagListView!
    
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var btnBudget: UIButton!
    @IBOutlet weak var lblBudget: UILabel!
    
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var lblReport: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onPressedStep(_ sender: UIButton) {
        if let stepRootVC = self.navigationController?.viewControllers.first as? JGGPostJobStepRootVC {
            var index: Int = 0
            if sender == btnDescribe {
                index = 0
            }
            else if sender == btnTime {
                index = 1
            }
            else if sender == btnAddress {
                index = 2
            }
            else if sender == btnBudget {
                index = 3
            }
            else if sender == btnReport {
                index = 4
            }
            stepRootVC.postJobStepView.selectStep(index: index)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
