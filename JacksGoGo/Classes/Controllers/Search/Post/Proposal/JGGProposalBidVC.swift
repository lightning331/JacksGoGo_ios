//
//  JGGProposalBidVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProposalBidVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var lblAppointmentPrice: UILabel!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtBreakdown: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


}
