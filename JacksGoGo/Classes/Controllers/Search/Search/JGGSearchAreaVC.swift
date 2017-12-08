//
//  JGGSearchAreaVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSearchAreaVC: JGGSearchBaseTableVC {

    @IBOutlet weak var btnDone: UIButton!
    
    fileprivate lazy var areas = [
        "CBD", "Central South", "Eunos", "Orchard", "Neweton", "Toa Payoh"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func onPressedDone(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGCheckboxButtonCell") as! JGGCheckboxButtonCell
        cell.checkboxButton.setTitle(areas[indexPath.row], for: .normal)
        cell.checkboxButton.setTitle(areas[indexPath.row], for: .selected)
        return cell
    }

}

class JGGCheckboxButtonCell: UITableViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton!
    
    @IBAction fileprivate func onPressedButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
    }
    
}
