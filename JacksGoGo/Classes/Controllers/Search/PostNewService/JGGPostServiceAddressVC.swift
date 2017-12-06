//
//  JGGPostServiceAddressVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceAddressVC: JGGPostServiceBaseTableVC {

    @IBOutlet weak var txtUnits: UITextField!
    @IBOutlet weak var txtStreet: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    @IBOutlet weak var btnDontShowFullAddress: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func onPressedDontShowMyFullAddress(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func onPressedNext(_ sender: UIButton) {
        super.onPressedNext(sender)
        if let parentVC = parent as? JGGPostServiceStepRootVC {
            parentVC.gotoSummaryVC()
        }
    }

    
}
