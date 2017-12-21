//
//  JGGSignupEmailPasswordVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSignupEmailPasswordVC: JGGLoginBaseVC {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    
    // MARK: - Button Actions
    
    @IBAction func onPressedSignup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoPhoneNumberVC", sender: self)
    }
    
    @IBAction func onPressedFacebook(_ sender: UIButton) {
    }
    
    //MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}
