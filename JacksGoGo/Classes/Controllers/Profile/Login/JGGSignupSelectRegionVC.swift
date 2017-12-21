//
//  JGGSignupSelectRegionVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSignupSelectRegionVC: JGGLoginBaseVC {

    @IBOutlet weak var btnSign: UIButton!
    
    private lazy var regions: [[String: String]] = [
        ["icon": "icon_singapore",
         "title": "Singapore"],
        ["icon": "icon_malaysia",
         "title": "Malaysia"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        self.hidesBottomBarWhenPushed = true
    }
    
    // MARK: - UITableView Datasource, delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGRegionSelectCell") as! JGGRegionSelectCell
        let image = UIImage(named: regions[indexPath.row]["icon"]!)
        let name = regions[indexPath.row]["title"]
        cell.btnCountryName.setImage(image, for: .normal)
        cell.btnCountryName.setTitle(name, for: .normal)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "gotoEmailPasswordVC", sender: indexPath)
    }
    
}

class JGGRegionSelectCell: UITableViewCell {
    
    @IBOutlet weak var btnCountryName: UIButton!
    
}
