//
//  JGGProposalNC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/13/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProposalNC: UINavigationController {

    var editProposal: JGGProposalModel? {
        set {
            _editProposal = newValue
            if let _ = newValue {
                isEditMode = true
            }
        }
        get {
            return _editProposal
        }
    }
    var appointment: JGGJobModel!
    
    private var _editProposal: JGGProposalModel?
    private var isEditMode: Bool = false
    private var isExecutedOne: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (!isExecutedOne && isEditMode) {
            isExecutedOne = true
            if let summaryVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGProposalSummaryVC") as? JGGProposalSummaryVC {
                summaryVC.proposal = editProposal
                summaryVC.appointment = appointment
                self.pushViewController(summaryVC, animated: false)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
