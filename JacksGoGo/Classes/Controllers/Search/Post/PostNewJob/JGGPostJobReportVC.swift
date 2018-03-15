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

    override func showOriginalInfo() {
        if let parent = self.parent as? JGGPostStepRootBaseVC,
            let editingJob = parent.editingJob
        {
            let reportType = editingJob.reportType
            setReportType(reportType)
        }
    }
    
    override func onPressedNext(_ sender: UIButton) {
        if let parentVC = parent as? JGGPostJobStepRootVC {
            
            updateData(self)
            
            NotificationCenter.default.post(name: NotificationUpdateJobContents, object: nil)
            
            parentVC.stepView.completeCurrentStep()
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
                else if selectView == viewPinCode {
                    reportType += 4
                }
            }
            if let editingJob = parentVC.editingJob {
                editingJob.reportType = reportType
            } else {
                parentVC.creatingJob?.reportType = reportType
            }
        }
    }
    
}
