//
//  JGGProposalSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/13/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import MBProgressHUD

class JGGProposalSummaryVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var lblDescribe: UILabel!
    
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnRescheduling: UIButton!
    @IBOutlet weak var lblRescheduling: UILabel!
    
    @IBOutlet weak var btnCancellation: UIButton!
    @IBOutlet weak var lblCancellation: UILabel!

    var appointment: JGGJobModel!
    var proposal: JGGProposalModel!
    var isEditMode: Bool = false
    
    private var hud: MBProgressHUD!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblDescribe.text = proposal.description_
        
        lblPrice.text = nil
        
        lblRescheduling.text = nil
        
        lblCancellation.text = nil
        
        if isEditMode {
            self.btnNext.setTitle(LocalizedString("Save Changes"), for: .normal)
        } else {
            self.btnNext.setTitle(LocalizedString("Submit Proposal"), for: .normal)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func onPressedStep(_ sender: UIButton) {
        if let stepRootVC = self.navigationController?.viewControllers.first as? JGGProposalStepRootVC {
            var index: Int = 0
            if sender == btnDescribe {
                index = 0
            }
            else if sender == btnPrice {
                index = 1
            }
            else if sender == btnRescheduling {
                index = 2
            }
            else if sender == btnCancellation {
                index = 3
            }
            stepRootVC.stepView.selectStep(index: index)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPressedPostNewJob(_ sender: UIButton) {
        
        submitProposal(proposal)
        
    }
    
    private func submitProposal(_ proposal: JGGProposalModel) {
        hud = MBProgressHUD.showAdded(to: self.parent!.parent!.parent!.view, animated: true)
        hud.mode = .indeterminate
    }
}
