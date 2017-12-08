//
//  JGGSearchVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSearchVC: JGGSearchBaseTableVC {

    @IBOutlet weak var viewSearchKeyword: UIView!
    @IBOutlet weak var txtSearchKeyword: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnAdvancedSearch: UIButton!
    
    @IBOutlet weak var btnOtherSearch1: UIButton!
    @IBOutlet weak var btnOtherSearch2: UIButton!
    @IBOutlet weak var btnOtherSearch3: UIButton!
    @IBOutlet weak var btnOtherSearch4: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBottomBarWhenPushed = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

class JGGSearchHeaderSectionCell: UITableViewCell {
    
    @IBOutlet weak var btnClear: UIButton!
    
}

class JGGSearchHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lblSearchHistory: UILabel!
    
    
}
