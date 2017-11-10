//
//  JGGCanInviteUserListVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit

class JGGCanInviteUserListVC: JGGViewController {

    @IBOutlet weak var viewTitleBox: UIView!
    @IBOutlet weak var imgviewCategoryIcon: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblServiceTime: UILabel!

    @IBOutlet weak var tableView: UITableView!
    
    var users: [JGGProviderUserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showCategoryAndTitle()
        initTableView()
        makeDummyData()
    }

    private func showCategoryAndTitle() {
        lblTitle.text = "Gardening"
        lblServiceTime.text = "21 Jul, 2017 10:00 AM - 12:00 PM"
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

    }
    
    private func makeDummyData() {
        let user00 = JGGProviderUserModel()
        user00.fullname = "CYYong"
        user00.rate = 4.8
        users.append(user00)
        
        let user01 = JGGProviderUserModel()
        user01.fullname = "Christina.P"
        user01.rate = 3.8
        users.append(user01)
        
        let user02 = JGGProviderUserModel()
        user02.fullname = "RenYW"
        user02.rate = 4.5
        users.append(user02)
        
        let user03 = JGGProviderUserModel()
        user03.fullname = "RositaV"
        user03.rate = 5.0
        users.append(user03)
        
        let user04 = JGGProviderUserModel()
        user04.fullname = "HeminW"
        user04.rate = 5.0
        users.append(user04)
        
        let user05 = JGGProviderUserModel()
        user05.fullname = "Alicia.Leong"
        user05.rate = 4.0
        users.append(user05)
        
        let user06 = JGGProviderUserModel()
        user06.fullname = "Rikita.M"
        user06.rate = 2.3
        users.append(user06)
        
        let user07 = JGGProviderUserModel()
        user07.fullname = "Amber.W"
        user07.rate = 5.0
        users.append(user07)
        
        let user08 = JGGProviderUserModel()
        user08.fullname = "Kelvin"
        user08.rate = 5.0
        users.append(user08)
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
        cell.user = users[indexPath.row]
        return cell
    }

}
