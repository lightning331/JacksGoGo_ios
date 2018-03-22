//
//  JGGServiceProvidersListVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGServiceProvidersListVC: JGGAppointmentDetailBaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnInvite: UIButton!
    
    var proposals: [JGGProposalModel] = []
    var invitedUsers: [JGGUserProfileModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        loadBiddedProviders()
    }
    
    private func initTableView() {
        self.tableView.register(UINib(nibName: "JGGAppInviteProviderCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppInviteProviderCell")
        
        self.tableView.register(UINib(nibName: "JGGAppBiddingProviderCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppBiddingProviderCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false
        self.tableView.backgroundColor = UIColor.JGGGrey5
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - API request
    
    private func loadBiddedProviders(pageIndex: Int = 0, pageSize: Int = 20) {
        if let jobId = self.selectedAppointment?.id {
            APIManager.getProposalsBy(jobId: jobId) { (proposals) in
                if pageIndex == 0 {
                    self.proposals = []
                }
                self.proposals.append(contentsOf: proposals)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func onPressedInvite(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func showUserProfile(_ userProfile: JGGUserProfileModel) {
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let publicProfileVC = profileStoryboard.instantiateViewController(withIdentifier: "JGGPublicProfileVC") as! JGGPublicProfileVC
        publicProfileVC.profile = userProfile
        self.navigationController?.pushViewController(publicProfileVC, animated: true)
    }
    
    @objc fileprivate func showProposal(_ proposal: JGGProposalModel) {
        let proposalVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGBidDetailVC") as! JGGBidDetailVC
        proposalVC.proposal = proposal
        self.navigationController?.pushViewController(proposalVC, animated: true)
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

extension JGGServiceProvidersListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return proposals.count + invitedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = indexPath.row
        if row < invitedUsers.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppInviteProviderCell") as! JGGAppInviteProviderCell
            cell.invitedMode()
            
            let user = invitedUsers[row]
            cell.profile = user
            cell.buttonAction = {
                
            }
            
            cell.setNewProvider(false)
            for u in invitedUsers {
                if user.id == u.id {
                    cell.setNewProvider(true)
                }
            }
            cell.tapProfileHandler = { (cell) in
                self.showUserProfile(cell.profile)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppBiddingProviderCell") as! JGGAppBiddingProviderCell
            cell.proposal = proposals[row - invitedUsers.count]
            cell.tapProposalHandler = { (cell) in
                self.showProposal(cell.proposal)
            }
            cell.tapProfileHandler = { (cell) in
                self.showUserProfile(cell.profile)
            }
            return cell
        }
    }
}
