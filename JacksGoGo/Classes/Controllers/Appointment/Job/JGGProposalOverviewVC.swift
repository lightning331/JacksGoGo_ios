//
//  JGGProposalOverviewVC.swift
//  JacksGoGo
//
//  Created by Chris Lin on 3/16/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProposalOverviewVC: JGGAppointmentDetailBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var proposal: JGGProposalModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGAppInviteProviderCell")
        registerCell(nibName: "JGGDetailInfoCenterAlignCell")

        if proposal.status != .confirmed {
            self.tableView.tableFooterView = nil
        }
    }

    @IBAction func onPressedEdit(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func onPressedDeleteProposal(_ sender: UIButton) {
        JGGAlertViewController.show(title: LocalizedString("Delete Proposal And Remove Bid?"),
                                    message: LocalizedString("This action cannot be undo."),
                                    colorSchema: .red,
                                    cancelColorSchema: .cyan,
                                    okButtonTitle: LocalizedString("Delete"),
                                    okAction: { text in
                                        
                                        
        },
                                    cancelButtonTitle: LocalizedString("Cancel"),
                                    cancelAction: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension JGGProposalOverviewVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppInviteProviderCell") as! JGGAppInviteProviderCell
            cell.btnInvite.isHidden = true
            cell.btnInvite.setTitle(" ", for: .normal)
            cell.user = proposal.userProfile
            return cell
        case 1, 2, 3, 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
            var imageName: String = ""
            var desc: String = ""
            var boldStrings: [String] = []
            if row == 1 {
                imageName = "icon_info"
                desc = proposal.description_ ?? ""
            }
            else if row == 2 {
                imageName = "icon_budget"
                desc = String(format: "$ %.2f", proposal.budget ?? 0)
            }
            else if row == 3 {
                imageName = "icon_reschedule"
                desc = String(format: "Rescheduling: %@", proposal.rescheduleTimeDescription() ?? "")
                boldStrings = ["Rescheduling:"]
            }
            else if row == 4 {
                imageName = "icon_cancellation"
                desc = String(format: "Cancellation: %@", proposal.cancellationTimeDescription() ?? "")
                boldStrings = ["Cancellation:"]
            }
            cell.icon = UIImage(named: imageName)
            cell.lblTitle.attributedText = desc.toBold(strings: boldStrings)

            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoCenterAlignCell") as! JGGDetailInfoCenterAlignCell
            let boldStr = String(format: LocalizedString("Proposal reference no.: %@"), proposal.id ?? "")
            let postTimeStr = String(format: LocalizedString("Posted on %@"), proposal.submitOn?.toString(format: .custom("d MMM, yyyy")).uppercased() ?? "")
            cell.title = boldStr
            cell.subTitle = postTimeStr
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
