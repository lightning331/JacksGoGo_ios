//
//  JGGRescheduleVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/14/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGRescheduleVC: JGGAppDetailBaseVC {

    @IBOutlet weak var btnRequestRescheduling: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction fileprivate func onPressedRequest(_ sender: UIButton) {
        JGGAlertViewController.show(title: LocalizedString("Request Sent!"),
                                    message: String(format: LocalizedString("%@ will be notified of the rescheduling, and be asked to respond."), "catherinedesilva"),
                                    colorSchema: .green,
                                    okButtonTitle: LocalizedString("OK"),
                                    okAction: { text in
                                        self.navigationController?.popViewController(animated: true)
                                    },
                                    cancelButtonTitle: nil,
                                    cancelAction: nil)
    }
    
    // MARK: - UITableView datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGRescheduleTimeCell") as! JGGRescheduleTimeCell
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGRescheduleReasonCell") as! JGGRescheduleReasonCell
            
            return cell
        }
        return UITableViewCell()
    }
}

class JGGRescheduleTimeCell: UITableViewCell {
    
    @IBOutlet weak var btnTime: UIButton!
    
}

class JGGRescheduleReasonCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtReason: UITextField!
    
}
