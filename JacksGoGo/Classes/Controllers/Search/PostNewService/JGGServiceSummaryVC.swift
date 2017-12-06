//
//  JGGServiceSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import TagListView

class JGGServiceSummaryVC: JGGPostServiceBaseTableVC {

    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var btnTimeSlot: UIButton!
    @IBOutlet weak var btnAddress: UIButton!
    
    @IBOutlet weak var lblDescribeTitle: UILabel!
    @IBOutlet weak var lblDescribeContent: UILabel!
    @IBOutlet weak var serviceTagView: TagListView!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnViewTimeSlots: UIButton!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    var isRequestQuotationMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isRequestQuotationMode {
//            self.tableView.tableFooterView = nil
        }
    }
    
    /*
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
    } */
    
    @IBAction func onPressedEditService(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPressedRequestQuotation(_ sender: UIButton) {
        
        JGGAlertViewController.show(title: LocalizedString("Service Posted!"),
                                    message: LocalizedString("Service reference no.:") + "S38291 - 11",
                                    colorSchema: .green,
                                    okButtonTitle: LocalizedString("View Post"),
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

}
