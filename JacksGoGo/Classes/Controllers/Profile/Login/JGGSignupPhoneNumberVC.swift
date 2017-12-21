//
//  JGGSignupPhoneNumberVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSignupPhoneNumberVC: JGGLoginBaseVC {

    @IBOutlet weak var btnRegion: UIButton!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    // MARK: - Button Actions
    
    @IBAction func onPressedRegion(_ sender: UIButton) {
    }
    
    @IBAction func onPressedNext(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoSMSVerifyVC", sender: self)
    }
    
    //MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
