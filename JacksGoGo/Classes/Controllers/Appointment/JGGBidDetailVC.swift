//
//  JGGBidDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGBidDetailVC: JGGAppointmentDetailBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnRejectBid: UIButton!
    @IBOutlet weak var btnAcceptBid: UIButton!
    @IBOutlet weak var constraintLeftPaddingOfAccentBidButton: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        constraintLeftPaddingOfAccentBidButton.constant = self.view.frame.width * 0.5
        
    }

    private func initTableView() {
        
        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }

        registerCell(nibName: "JGGUserAvatarNameRateCell")
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGDetailInfoAccessoryButtonCell")
        registerCell(nibName: "JGGDetailInfoCenterAlignCell")

        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false
        self.tableView.backgroundColor = UIColor.JGGGrey5
        
    }
    
    @IBAction func onPressedRejectBid(_ sender: Any) {
        JGGAlertViewController.show(title: LocalizedString("Reject this bid?"),
                                    message: nil,
                                    colorSchema: .green,
                                    okButtonTitle: LocalizedString("Reject"),
                                    okAction: { text in
            
        },
                                    cancelButtonTitle: LocalizedString("Cancel"),
                                    cancelAction: nil)
    }
    
    @IBAction func onPressedAcceptBid(_ sender: Any) {
        JGGActionSheet.showInteraction(title: LocalizedString("Choose a package:"),
                                       primaryButtonTitle: LocalizedString("One-Time:") + " $ 100.00",
                                       secondaryButtonTitle: LocalizedString("Package:") + " $ 800.00 for 10",
                                       cancelButtonTitle: LocalizedString("Cancel"),
                                       primaryButtonAction: {
            
        }, secondaryButtonAction: {
            
        }, cancelButtonAction: nil)
    }
    
}

extension JGGBidDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            // User Profile
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGUserAvatarNameRateCell") as! JGGUserAvatarNameRateCell
            
            return cell
        }
        else if 1 <= row && row <= 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
            if row == 1 {
                // Cover leter
                cell.icon = UIImage(named: "icon_info")
                cell.title = "We are a team of 5 with 8+ experience in cleaning. We can send over 2 cleaners and have the work done in 1 hour."
                cell.lblTitle.font = UIFont.JGGListText
            }
            else if row == 2 {
                // Price
                cell.icon = UIImage(named: "icon_budget")
                let content = String.attributedWith(bold: "$ 100.00", regular: "\n- Our own supplies $20.")
                cell.lblTitle.attributedText = content
            }
            else if row == 3 {
                // Package
                cell.icon = UIImage(named: "icon_budget")
                let content = String.attributedWith(bold: "$ 800.00 for 100", regular: "\n- Min. 3 days prior booking required. Booking subject to availability.\n- Must be same address.")
                cell.lblTitle.attributedText = content
            }
            else if row == 4 {
                // Time
                cell.icon = UIImage(named: "icon_reschedule")
                let content = String.attributedWith(bold: "Rescheduling:", regular: " at least 1 day before.")
                cell.lblTitle.attributedText = content
            }
            return cell
        }
        
        else if row == 5 {
            // Proposal refernece
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoCenterAlignCell") as! JGGDetailInfoCenterAlignCell
            cell.lblTitle.text = LocalizedString("Proposal reference no.:") + " P3829-11"
            cell.lblSubTitle.text = LocalizedString("Posted on") + " 7 Jul, 2017"
            return cell
        }
        return UITableViewCell()
    }
}
