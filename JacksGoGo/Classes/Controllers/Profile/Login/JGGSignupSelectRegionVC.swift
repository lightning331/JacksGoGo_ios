//
//  JGGSignupSelectRegionVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import ESPullToRefresh

class JGGSignupSelectRegionVC: JGGLoginBaseVC {

    @IBOutlet weak var btnSign: UIButton!
    
//    private lazy var regions: [[String: String]] = [
//        ["icon": "icon_singapore",
//         "title": "Singapore"],
//        ["icon": "icon_malaysia",
//         "title": "Malaysia"],
//    ]

    private lazy var regions: [JGGRegionModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        self.hidesBottomBarWhenPushed = true
        
        self.tableView.es.addPullToRefresh {
            self.APIManager.getRegions { (regions) in
                self.regions = regions
                self.tableView.reloadData()
                self.tableView.es.stopPullToRefresh()
            }
        }
        self.tableView.es.startPullToRefresh()
    }
    
    
    // MARK: - UITableView Datasource, delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGRegionSelectCell") as! JGGRegionSelectCell
        let region = regions[indexPath.row]
        cell.btnCountryName.setTitle(region.name, for: .normal)
        if region.name.lowercased() == "singapore" {
            cell.btnCountryName.setImage(UIImage(named: "icon_singapore"), for: .normal)
        } else if region.name.lowercased() == "malaysia" {
            cell.btnCountryName.setImage(UIImage(named: "icon_malaysia"), for: .normal)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        (self.navigationController as! JGGProfileNC).selectedRegion = regions[indexPath.row]
        self.performSegue(withIdentifier: "gotoEmailPasswordVC", sender: indexPath)
    }
    
}

class JGGRegionSelectCell: UITableViewCell {
    
    @IBOutlet weak var btnCountryName: UIButton!
    
}
