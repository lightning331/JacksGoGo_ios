//
//  JGGPostJobStepRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostJobStepRootVC: JGGViewController, JGGAppointmentDetailStepHeaderViewDelegate {

    @IBOutlet weak var postJobStepViewContainer: UIView!
    var postJobStepView: JGGJobPostStepHeaderView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var containerDescribe: UIView!
    @IBOutlet weak var containerTime: UIView!
    @IBOutlet weak var containerAddress: UIView!
    @IBOutlet weak var containerBudget: UIView!
    @IBOutlet weak var containerReport: UIView!

    var selectedCategory: JGGCategoryModel!
    var creatingJob: JGGCreateJobModel?
    var editingJob: JGGJobModel?
    fileprivate var isEditMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let nav = self.navigationController as? JGGPostJobNC, let editJob = nav.editJob {
            editingJob = editJob
            isEditMode = true
        } else {
            creatingJob = JGGCreateJobModel()
            creatingJob?.categoryId = selectedCategory.id
            creatingJob?.userProfileId = appManager.currentUser?.id
            creatingJob?.regionId = appManager.currentRegion?.id
            creatingJob?.currencyCode = appManager.currentRegion?.currencyCode
        }
        
        postJobStepView =
            UINib(nibName: "JGGJobPostStepHeaderView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as! JGGJobPostStepHeaderView
        postJobStepView.delegate = self
        postJobStepViewContainer.addSubview(postJobStepView)
        postJobStepView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        postJobStepView.setCompletedStep(
            describe: isEditMode,
            time: isEditMode,
            address: isEditMode,
            budget: isEditMode,
            report: isEditMode
        )

        mainScrollView.isScrollEnabled = false
    }
    
    func jobDetailStep(selected: Int) {
        switch selected {
        case 0:
            mainScrollView.setContentOffset(CGPoint(x: mainScrollView.frame.width * 0, y: 0), animated: true)
            break
        case 1:
            mainScrollView.setContentOffset(CGPoint(x: mainScrollView.frame.width * 1, y: 0), animated: true)
            break
        case 2:
            mainScrollView.setContentOffset(CGPoint(x: mainScrollView.frame.width * 2, y: 0), animated: true)
            break
        case 3:
            mainScrollView.setContentOffset(CGPoint(x: mainScrollView.frame.width * 3, y: 0), animated: true)
            break
        case 4:
            mainScrollView.setContentOffset(CGPoint(x: mainScrollView.frame.width * 4, y: 0), animated: true)
            break
        default:
            
            break
        }
    }
    
    func gotoSummaryVC() -> Void {
        let summaryVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGPostJobSummaryVC") as! JGGPostJobSummaryVC
        if let editJob = editingJob {
            summaryVC.editingJob = editJob
        } else {
            summaryVC.creatingJob = self.creatingJob
        }
        self.navigationController?.pushViewController(summaryVC, animated: true)
    }


}
