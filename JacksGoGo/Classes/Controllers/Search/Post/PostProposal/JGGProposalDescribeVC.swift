//
//  JGGProposalDescribeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGProposalDescribeVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var lblAppointmentDescription: UILabel!
    @IBOutlet weak var txtDescribe: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showOriginalProposal()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let proposalStepRootVC = self.parent as? JGGProposalStepRootVC
        lblAppointmentDescription.text = proposalStepRootVC?.appointment.description_

    }
    
    private func showOriginalProposal() {
        let proposal = (self.parent as? JGGProposalStepRootVC)?.proposal
        txtDescribe.text = proposal?.description_
    }
    
    override func onPressedNext(_ sender: UIButton) {
        if txtDescribe.text.count < 10 {
            Toast(text: LocalizedString("Please enter at least 10 character in describe"), delay: 0, duration: 3).show()
        } else {
            super.onPressedNext(sender)
        }
    }
    
    override func updateData(_ sender: Any) {
        if let parentVC = self.parent as? JGGProposalStepRootVC {
            parentVC.proposal?.description_ = txtDescribe.text
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
