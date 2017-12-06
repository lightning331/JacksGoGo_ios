//
//  JGGPostServiceStepRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceStepRootVC: JGGViewController, JGGJobDetailStepHeaderViewDelegate {

    @IBOutlet weak var postServiceStepViewContainer: UIView!
    var postServiceStepView: JGGJobDetailStepHeaderView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var containerDescribe: UIView!
    @IBOutlet weak var containerPrice: UIView!
    @IBOutlet weak var containerTime: UIView!
    @IBOutlet weak var containerAddress: UIView!
    
    var isEditMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postServiceStepView =
            UINib(nibName: "JGGJobDetailStepHeaderView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as! JGGJobDetailStepHeaderView
        postServiceStepView.delegate = self
        postServiceStepViewContainer.addSubview(postServiceStepView)
        postServiceStepView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        if isEditMode {
            postServiceStepView.setCompletedStep(describe: true,
                                                 price: true,
                                                 time: true,
                                                 address: true)

        } else {
            postServiceStepView.setCompletedStep(describe: false,
                                                 price: false,
                                                 time: false,
                                                 address: false)

        }
        
        mainScrollView.isScrollEnabled = false
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
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
        let summaryVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGServiceSummaryVC") as! JGGServiceSummaryVC
        summaryVC.isRequestQuotationMode = true
        self.navigationController?.pushViewController(summaryVC, animated: true)
    }

}
