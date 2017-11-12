//
//  JGGActiveServicesAroundVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGActiveServicesAroundVC: JGGBottomBarAnimatingVC {

    @IBOutlet weak var btnPostNewService: UIButton!
    @IBOutlet weak var btnByDistance: UIButton!
    @IBOutlet weak var btnByRatings: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnMapView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        self.navigationController?.hidesBarsOnSwipe = true
        
    }
    
    private func initTableView() {
        self.tableView?.register(UINib(nibName: "JGGServiceListCell", bundle: nil),
                                 forCellReuseIdentifier: "JGGServiceListCell")
        
        self.tableView?.estimatedRowHeight = 138
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.separatorStyle = .none
        self.tableView?.allowsSelection = true
        
    }
    
    override func shouldHideNavigationBarManually() -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGServiceListCell") as! JGGServiceListCell
        
        return cell
    }

}
