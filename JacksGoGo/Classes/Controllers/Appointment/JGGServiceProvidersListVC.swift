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
    
    var users: [JGGUserProfileModel] = []
    var invitedUsers: [JGGUserProfileModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        loadBiddedProviders()
    }
    
    private func initTableView() {
        self.tableView.register(UINib(nibName: "JGGAppInviteProviderCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppInviteProviderCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false
        self.tableView.backgroundColor = UIColor.JGGGrey5
        
    }
    
    // MARK: - API request
    
    private func loadBiddedProviders(pageIndex: Int = 0, pageSize: Int = 20) {
        if let jobId = (self.selectedAppointment as? JGGJobModel)?.id {
            APIManager.getProposalsBy(jobId: jobId) { (proposals) in
                self.users = proposals.map { $0.userProfile! }
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressedInvite(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        return invitedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppInviteProviderCell") as! JGGAppInviteProviderCell
        cell.invitedMode()
        let user = invitedUsers[indexPath.row]
        cell.user = user
        cell.buttonAction = {
            
        }
        
        cell.setNewProvider(false)
        for u in invitedUsers {
            if user.id == u.id {
                cell.setNewProvider(true)
            }
        }
        return cell
    }
}
