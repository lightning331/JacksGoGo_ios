//
//  JGGProposalStepRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/13/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProposalStepRootVC: JGGViewController, JGGAppointmentDetailStepHeaderViewDelegate {

    @IBOutlet weak var stepViewContainer: UIView!
    var stepView: JGGJobDetailStepHeaderView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var containerDescribe: UIView!
    @IBOutlet weak var containerBid: UIView!
    @IBOutlet weak var containerRescheduling: UIView!
    @IBOutlet weak var containerCancellation: UIView!

    var isEditMode: Bool = false
    
    var selectedCategory: JGGCategoryModel!
    var appointment: JGGJobModel!
    var proposal: JGGProposalModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepView =
            UINib(nibName: "JGGProposalStepHeaderView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as! JGGProposalStepHeaderView

        stepView.delegate = self
        stepViewContainer.addSubview(stepView)
        stepView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        
        mainScrollView.isScrollEnabled = false
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if proposal == nil {
            proposal = JGGProposalModel()
            proposal?.appointment = appointment
            proposal?.appointmentId = appointment.id
            proposal?.userProfile = appManager.currentUser
            proposal?.userProfileId = appManager.currentUser?.id
        }
        
        (stepView as! JGGProposalStepHeaderView).setCompletedStep(
            describe: isEditMode,
            bid: isEditMode,
            rescheduling: isEditMode,
            cancellation: isEditMode
        )
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        default:
            
            break
        }
    }
    
    func gotoSummaryVC() -> Void {
        let summaryVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGProposalSummaryVC") as! JGGProposalSummaryVC
        summaryVC.appointment = self.appointment
        summaryVC.proposal = proposal!
        self.navigationController?.pushViewController(summaryVC, animated: true)
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
