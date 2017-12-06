//
//  JGGPostServiceTimeSlotsFinalVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceTimeSlotsFinalVC: JGGPostServiceBaseTableVC {

    @IBOutlet weak var btnTimeSlotsType: JGGYellowSelectingButton!
    @IBOutlet weak var btnViewTimeSlots: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTimeSlotsType.select(true)
    }

    override func onPressedNext(_ sender: UIButton) {
        if let parentVC = self.navigationController?.parent as? JGGPostServiceStepRootVC {
            parentVC.postServiceStepView.completeCurrentStep()
            parentVC.postServiceStepView.nextStep()
        }
    }

    @IBAction func onPressedViewTimeSlots(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}
