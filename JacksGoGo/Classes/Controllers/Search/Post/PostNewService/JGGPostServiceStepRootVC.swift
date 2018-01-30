//
//  JGGPostServiceStepRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceStepRootVC: JGGPostStepRootBaseVC {

    @IBOutlet weak var containerDescribe: UIView!
    @IBOutlet weak var containerPrice: UIView!
    @IBOutlet weak var containerTime: UIView!
    @IBOutlet weak var containerAddress: UIView!
    
    override func viewDidLoad() {
        
        stepView =
            UINib(nibName: "JGGJobDetailStepHeaderView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as! JGGJobDetailStepHeaderView

        super.viewDidLoad()
        
        if creatingJob == nil {
            isEditMode = false
            creatingJob = JGGCreateJobModel()
            creatingJob!.categoryId = selectedCategory.id
            creatingJob!.userProfileId = appManager.currentUser?.id
            creatingJob!.regionId = appManager.currentRegion?.id
            creatingJob!.currencyCode = appManager.currentRegion?.currencyCode
            creatingJob!.isRequest = false
        } else {
            isEditMode = true
            
        }
        
        stepView.setCompletedStep(describe: isEditMode,
                                  price: isEditMode,
                                  time: isEditMode,
                                  address: isEditMode)

        
    }
    
    override func jobDetailStep(selected: Int) {
        if selected != 2 {
            (self.navigationController?.parent as? JGGPostServiceRootVC)?.removeTodayButton()
        }
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
        default:
            
            break
        }
    }
    
    override func gotoSummaryVC() -> Void {
        let summaryVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGServiceSummaryVC") as! JGGServiceSummaryVC
//        summaryVC.isRequestQuotationMode = true
        summaryVC.creatingService = self.creatingJob
        self.navigationController?.pushViewController(summaryVC, animated: true)
    }

}
