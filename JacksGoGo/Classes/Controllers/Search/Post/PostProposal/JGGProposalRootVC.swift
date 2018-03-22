//
//  JGGProposalRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/15/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProposalRootVC: JGGViewController {

    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgviewCategoryIcon: UIImageView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobTime: UILabel!
    
    var job: JGGJobModel!
    var editProposal: JGGProposalModel? {
        didSet {
            if let editProposal = editProposal, editProposal.status == .open {
                isEditMode = true
            }
        }
    }
    fileprivate var isEditMode: Bool = false
    
    var changedProposalHandler: ((JGGProposalModel) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgviewCategoryIcon.image = nil
        if let url = job.category?.imageURL() {
            imgviewCategoryIcon.af_setImage(withURL: url)
        }
        lblJobTitle.text = job.title
        lblJobTime.text = job.jobTimeDescription()
        
        if isEditMode {
            let btnSave = UIBarButtonItem(
                title: LocalizedString("Save"),
                style: .plain,
                target: self,
                action: #selector(onPressedSaveProposal(_:))
            )
            btnSave.tintColor = UIColor.JGGCyan
            self.navigationItem.rightBarButtonItem = btnSave
        }
    }

    @objc func onPressedSaveProposal(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NotificationEditProposalSave, object: nil)
    }
    

    @IBAction func onPressedBack(_ sender: Any) {
        let alertTitle: String = LocalizedString("Quit Editing A Proposal?")
        let message: String = LocalizedString("All info will be lost.")
        
        JGGAlertViewController.show(title: alertTitle,
                                    message: message,
                                    colorSchema: .red,
                                    cancelColorSchema: .cyan,
                                    okButtonTitle: LocalizedString("Quit"),
                                    okAction: { text in
                                        self.navigationController?.popViewController(animated: true)
        },
                                    cancelButtonTitle: LocalizedString("Cancel"),
                                    cancelAction: nil)

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
            if segueId == "gotoProposalStepRootVC" {
                let nav = segue.destination as! JGGProposalNC
                nav.appointment = job
                nav.editProposal = editProposal
            }
        }
    }
    

}
