//
//  JGGEditJobSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGEditJobSummaryVC: JGGEditJobBaseTableVC {

    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    
    @IBOutlet weak var lblDescribeTitle: UILabel!
    @IBOutlet weak var lblDescribeContent: UILabel!
    @IBOutlet weak var collectionViewPictures: UICollectionView!
    
    @IBOutlet weak var lblJobTimeType: UILabel!
    @IBOutlet weak var lblJobTime: UILabel!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var lblReportType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPressedEditJob(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoEditJobRootVC", sender: sender)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
