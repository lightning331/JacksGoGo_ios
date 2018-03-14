//
//  JGGProposalReschedulingVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProposalReschedulingVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var lblAppointmentTime: UILabel!
    @IBOutlet weak var btnNoAllow: JGGYellowSelectingButton!
    @IBOutlet weak var btnAllow: JGGYellowSelectingButton!
    @IBOutlet weak var txtDay: UITextField!
    @IBOutlet weak var txtHour: UITextField!
    @IBOutlet weak var txtMinutes: UITextField!
    @IBOutlet weak var txtTerms: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

}
