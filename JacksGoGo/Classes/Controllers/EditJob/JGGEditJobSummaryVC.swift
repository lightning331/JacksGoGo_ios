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
    
    var isRequestQuotationMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !isRequestQuotationMode {
            self.tableView.tableFooterView = nil
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let index = self.navigationController?.viewControllers.index(of: self),
            index > 0,
            isRequestQuotationMode == true
        {
            let vcs = [self]
            self.navigationController?.viewControllers = vcs
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.hidesBarsOnSwipe = false
        }
    }

    @IBAction func onPressedEditJob(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoEditJobRootVC", sender: sender)
    }
    
    @IBAction func onPressedRequestQuotation(_ sender: UIButton) {
        
        JGGAlertViewController.show(title: LocalizedString("Job Posted!"),
                                    message: LocalizedString("Job reference no.:") + "J38291 - 170721",
                                    colorSchema: .green,
                                    okButtonTitle: LocalizedString("View Job"),
                                    okAction: {
                                        self.navigationController?
                                            .parent?
                                            .navigationController?
                                            .popToRootViewController(animated: true)
                                    },
                                    cancelButtonTitle: nil,
                                    cancelAction: nil)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
