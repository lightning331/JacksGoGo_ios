//
//  JGGAllReviewsVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/21/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos

class JGGAllReviewsVC: JGGSearchBaseVC {

    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var ratebarTotal: CosmosView!
    
    fileprivate lazy var dummyReview: [String] = [
        "I enjoy the classes.",
        "I like the swim club she teachers in. Her classes are easy to fllow.",
        "10 people in a group, but ester can handle all of us very well. Love her easy to learn tacticks.",
        "Very patient instructor",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func initTableView() {
        
        self.tableView.register(UINib(nibName: "JGGUserReviewCell", bundle: nil),
                                forCellReuseIdentifier: "JGGUserReviewCell")
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false
        
    }

}

extension JGGAllReviewsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGUserReviewCell") as! JGGUserReviewCell
        cell.lblReview.text = dummyReview[Int(arc4random_uniform(UInt32(dummyReview.count)))]
        return cell
    }
    
}
