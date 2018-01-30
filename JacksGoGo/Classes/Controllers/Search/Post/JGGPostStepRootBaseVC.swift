//
//  JGGPostStepRootBaseVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/31/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostStepRootBaseVC: JGGViewController, JGGAppointmentDetailStepHeaderViewDelegate {

    @IBOutlet weak var stepViewContainer: UIView!
    var stepView: JGGJobDetailStepHeaderView!
    @IBOutlet weak var mainScrollView: UIScrollView!

    var isEditMode: Bool = false
    
    var selectedCategory: JGGCategoryModel!
    var creatingJob: JGGJobModel?
    var editingJob: JGGJobModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepView.delegate = self
        stepViewContainer.addSubview(stepView)
        stepView.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        
        mainScrollView.isScrollEnabled = false
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func jobDetailStep(selected: Int) {
        
    }
    
    func gotoSummaryVC() -> Void {
        
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
