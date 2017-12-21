//
//  JGGLoginVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGLoginVC: JGGLoginBaseVC {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var btnSigninFacebook: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tableView.keyboardDismissMode = .onDrag
    }
    
    //MARK: - Button Actions
    @IBAction func onPressedForgotPassword(_ sender: UIButton) {
    
    }
    
    @IBAction func onPressedSignin(_ sender: UIButton) {
    
    }
    
    @IBAction func onPressedFacebook(_ sender: UIButton) {
    
    }
    
    //MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
