//
//  JGGCanInviteUserListVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit

class JGGCanInviteUserListVC: JGGAppointmentDetailBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [JGGUserProfileModel] = []
    var invitedUsers: [JGGUserProfileModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        loadProviders()
    }

    private func initTableView() {
        let view = UIView(frame: CGRect(origin: CGPoint.zero,
                                        size: CGSize(width: self.view.frame.width,
                                                     height: 110)))
        view.backgroundColor = UIColor.JGGGrey5
        let label = UILabel()
        label.font = UIFont.JGGListText
        label.textColor = UIColor.JGGGrey1
        label.numberOfLines = 0
        label.text = LocalizedString("Here are some recommendations for your posted job. Inviting people to your job increases the chances of finding a perfect match.")
        view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview().offset(16)
            maker.right.bottom.equalToSuperview().offset(-16)
        }
        let viewSeperater = UIView(frame: CGRect(x: 0, y: 99, width: view.frame.width, height: 1))
        viewSeperater.backgroundColor = UIColor.JGGGrey4
        view.addSubview(viewSeperater)
        viewSeperater.snp.makeConstraints { (maker) in
            maker.left.bottom.right.equalToSuperview()
            maker.height.equalTo(1)
        }
        self.tableView.tableHeaderView = view
        
        self.tableView.register(UINib(nibName: "JGGAppInviteProviderCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppInviteProviderCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false
        self.tableView.backgroundColor = UIColor.JGGGrey5

    }
    
    private func loadProviders(pageIndex: Int = 0, pageSize: Int = 20) {
        APIManager.getProvidersForInvite(pageIndex: pageIndex, pageSize: pageSize) { (result) in
            if pageIndex == 0 {
                self.users.removeAll()
            }
            self.users.append(contentsOf: result)
            self.tableView.reloadData()
        }
    }
    
    @objc fileprivate func showUserProfile(_ userProfile: JGGUserProfileModel) {
        let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let publicProfileVC = profileStoryboard.instantiateViewController(withIdentifier: "JGGPublicProfileVC") as! JGGPublicProfileVC
        publicProfileVC.profile = userProfile
        self.navigationController?.pushViewController(publicProfileVC, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
            if segueId == "gotoServiceProvidersListVC" {
                let vc = segue.destination as? JGGServiceProvidersListVC
                vc?.invitedUsers = self.invitedUsers
            }
        }
    }

}

extension JGGCanInviteUserListVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppInviteProviderCell") as! JGGAppInviteProviderCell
        let user = users[indexPath.row]
        cell.profile = user
        cell.buttonAction = {
            self.inviteUser(user)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        cell.disableInviteButton(false)
        
        for u in invitedUsers {
            if user.id == u.id {
                cell.disableInviteButton()
            }
        }
        cell.tapProfileHandler = { (cell) in
            self.showUserProfile(cell.profile)
        }
        return cell
    }
    
    private func inviteUser(_ user: JGGUserProfileModel) {
        invitedUsers.append(user)
        if let job = self.selectedAppointment {
            APIManager.sendInvite(appointment: job, user: user) { (success, errorMessage) in
                if success {
                    
                } else {
                    print("Invite ERROR :", errorMessage ?? "")
                }
            }
        }
    }

}
