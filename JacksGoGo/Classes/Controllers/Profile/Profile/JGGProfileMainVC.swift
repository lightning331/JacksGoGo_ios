//
//  JGGProfileMainVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/23/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MBProgressHUD

class JGGProfileMainVC: JGGStartTableVC {

    @IBOutlet weak var imgviewProfileBanner: UIImageView!
    @IBOutlet weak var viewCredit: UIView!
    @IBOutlet weak var lblCreditAmount: UILabel!
    @IBOutlet weak var viewPoints: UIView!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var viewUsername: UIView!
    @IBOutlet weak var imgviewUserAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var viewRegion: UIView!
    @IBOutlet weak var imgviewCountryFlag: UIImageView!
    @IBOutlet weak var lblRegionName: UILabel!
    @IBOutlet weak var btnChangeRegion: UIButton!
    
    fileprivate let options: [[String]] = [
        [
            LocalizedString("Joined GoClubs"),
            LocalizedString("Service Listing"),
        ],
        [
            LocalizedString("Payment Method"),
            LocalizedString("Settings"),
            ],
        [
            LocalizedString("Talk To Us"),
            LocalizedString("About JacksGoGo"),
            ],
        [
            LocalizedString("Sign Out"),
            ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsSelection = true
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 16))
        view.backgroundColor = UIColor.JGGGrey5
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        lineView.backgroundColor = UIColor.JGGGrey4
        view.addSubview(lineView)
        
        return view
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 16))
        view.backgroundColor = UIColor.JGGGrey5
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGProfileMainOptionCell") as! JGGProfileMainOptionCell
        cell.lblTitle.text = options[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? JGGProfileMainOptionCell {
            let optionTitle = cell.lblTitle.text
            if optionTitle == LocalizedString("Sign Out") {
                let hud = MBProgressHUD(view: (self.tabBarController?.view)!)
                hud.show(animated: true)
                APIManager.accountLogout({ (success, errorMessage) in
                    if success {
                        self.appManager.currentUser = nil
                        NotificationCenter
                            .default
                            .post(
                                name: NSNotification.Name(rawValue: JGGNotificationLoggedOut),
                                object: nil
                        )
                        (self.navigationController as? JGGProfileNC)?.loggedOut()
                    } else {
                        JGGAlertViewController.show(
                            title: LocalizedString("Error"),
                            message: errorMessage,
                            colorSchema: .red,
                            okButtonTitle: LocalizedString("OK"),
                            okAction: nil,
                            cancelButtonTitle: nil,
                            cancelAction: nil
                        )
                    }
                    hud.hide(animated: true)
                })
            }
        }
    }
}

class JGGProfileMainOptionCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
}
