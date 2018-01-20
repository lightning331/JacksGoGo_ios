//
//  JGGPostJobReportVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/29/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostJobReportVC: JGGEditJobReportVC {

    override func viewDidLoad() {
        defaultColor = UIColor.JGGCyan
        super.viewDidLoad()
        if SHOW_TEMP_DATA {
            showTemporaryData()
        }
    }
    
    private func showTemporaryData() {
        onPressReportType(viewPinCode.gestureRecognizers?.first as! UITapGestureRecognizer)
    }

    override func onPressedNext(_ sender: UIButton) {
        if let parentVC = parent as? JGGPostJobStepRootVC {
            
            updateData(self)
            
            NotificationCenter.default.post(name: NSNotification.Name("UpdateData"), object: nil)
            
            parentVC.postJobStepView.completeCurrentStep()
            parentVC.gotoSummaryVC()

        }
    }

    override func updateData(_ sender: Any) {
        if let parentVC = parent as? JGGPostJobStepRootVC {
            
            var reportType: Int = 0
            for selectView in selectedViews {
                if selectView == viewBeforeAndAfterPhoto {
                    reportType += 1
                }
                else if selectView == viewGeotracking {
                    reportType += 2
                }
                if selectView == viewPinCode {
                    reportType += 4
                }
            }
            parentVC.creatingJob.reportType = reportType
            
        }
    }
    
}
