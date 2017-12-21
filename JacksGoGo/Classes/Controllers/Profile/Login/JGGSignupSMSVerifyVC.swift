//
//  JGGSignupSMSVerifyVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSignupSMSVerifyVC: JGGLoginBaseVC {

    @IBOutlet weak var lblTimeInterval: UILabel!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBAction func onPressedResendOTP(_ sender: UIButton) {
    }
    
    @IBAction func onPressedSubmit(_ sender: UIButton) {
    }
    
    //MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}
