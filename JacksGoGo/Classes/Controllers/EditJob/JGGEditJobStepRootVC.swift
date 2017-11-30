//
//  JGGEditJobStepRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit

class JGGEditJobStepRootVC: JGGViewController, JGGJobDetailStepHeaderViewDelegate {

    @IBOutlet weak var editJobStepViewContainer: UIView!
    var editJobStepView: JGGJobDetailStepHeaderView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var containerDescribe: UIView!
    @IBOutlet weak var containerTime: UIView!
    @IBOutlet weak var containerAddress: UIView!
    @IBOutlet weak var containerReport: UIView!

    var isRequestQuotationMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editJobStepView =
            UINib(nibName: "JGGJobDetailStepHeaderView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as! JGGJobDetailStepHeaderView
        editJobStepView.delegate = self
        editJobStepViewContainer.addSubview(editJobStepView)
        editJobStepView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        if isRequestQuotationMode {
            editJobStepView.setCompletedStep(describe: false,
                                             time: false,
                                             address: false,
                                             report: false)
        } else {
            editJobStepView.setCompletedStep(describe: true,
                                             time: true,
                                             address: true,
                                             report: true)
        }
        
        mainScrollView.isScrollEnabled = false
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
