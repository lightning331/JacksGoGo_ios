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
    
    var proposal: JGGProposalModel! {
        didSet {
            self.selectedAppointment = proposal.appointment
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "gotoEditProposalVC" {
            if let _ = proposal.clone() {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
            if segueId == "gotoEditProposalVC" {
                let editProposalVC = segue.destination as! JGGProposalRootVC
                editProposalVC.editProposal = proposal.clone()!
                editProposalVC.job = proposal.appointment
                editProposalVC.changedProposalHandler = { proposal in
                    self.proposal.update(with: proposal.json())
                    self.tableView.reloadData()
                }
            } else if segueId == "gotoUserProfileVC" {
                let profileVC = segue.destination as! JGGPublicProfileVC
                profileVC.profile = proposal.userProfile!
            }
        }
    }
    

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
            cell.profile = proposal.userProfile
            cell.tapProfileHandler = { (cell) in
                self.performSegue(withIdentifier: "gotoUserProfileVC", sender: self)
            }
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
