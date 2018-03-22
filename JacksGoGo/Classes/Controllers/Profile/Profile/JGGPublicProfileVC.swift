//
//  JGGPublicProfileVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/23/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPublicProfileVC: JGGProfileSummaryVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = self.navigationItem.rightBarButtonItem
        if profile.id == appManager.currentUser?.id {
            rightButton?.image = UIImage(named: "button_edit_green")
        } else {
            rightButton?.image = UIImage(named: "button_favourite_outline_green")
        }
        
    }
    
    override func onPressedEdit(_ sender: UIBarButtonItem) {
        if profile.id == appManager.currentUser?.id {
            super.onPressedEdit(sender)
        } else {
            favoriteUser()
        }
    }
    
    fileprivate func favoriteUser() {
        print("Favorite user")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if indexPath.section == 0 {
            if row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTotalReviewCell") as! JGGTotalReviewCell
                cell.ratebarTotalReviews.rating = profile.user.rate
                cell.ratebarTotalReviews.text = nil
                cell.btnSeeAllReviews.setTitleColor(UIColor.JGGOrange, for: .normal)
                return cell
            } else if 0 < row && row < 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
                var iconName: String = "icon_info"
                var content: String = ""
                if row == 1 {
                    content = profile.user.overview ?? LocalizedString("Not set")
                } else if row == 2 {
                    iconName = "icon_location"
                    content = profile.fullBillingAddress()
                }
                cell.icon = UIImage(named: iconName)
                cell.title = content
                return cell
            } else if row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGBorderButtonCell") as! JGGBorderButtonCell
                var username: String = "This user"
                if let fullname = profile.user.fullname {
                    username = fullname
                }
                cell.buttonTitle = LocalizedString("View All Services by ") + username
                cell.btnPrimary.setTitleColor(UIColor.JGGOrange, for: .normal)
                cell.btnPrimary.borderColor = UIColor.JGGOrange
                return cell
            } else if row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTagListCell") as! JGGTagListCell
                
                return cell
            }
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }

}
