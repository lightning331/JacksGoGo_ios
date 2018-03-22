//
//  JGGProfileSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/23/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProfileSummaryVC: JGGProfileBaseVC {

    @IBOutlet weak var viewCarouselContainer: UIView!
    @IBOutlet weak var lblUsername: UILabel!
    
    var profile: JGGUserProfileModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGTagListCell")
        registerCell(nibName: "JGGBorderButtonCell")
        registerCell(nibName: "JGGTotalReviewCell")

        self.tableView.register(UINib(nibName: "JGGSectionTitleView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "JGGSectionTitleView")
        
        self.lblUsername.text = profile.user.fullname
    }

    @IBAction func onPressedEdit(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
