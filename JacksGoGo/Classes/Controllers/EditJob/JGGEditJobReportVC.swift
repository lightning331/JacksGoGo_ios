//
//  JGGEditJobReportVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGEditJobReportVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var viewBeforeAndAfterPhoto: UIView!
    @IBOutlet weak var lblBeforeTitle: UILabel!
    @IBOutlet weak var lblBeforeDescription: UILabel!
    
    @IBOutlet weak var viewGeotracking: UIView!
    @IBOutlet weak var lblGeotrackingTitle: UILabel!
    @IBOutlet weak var lblGeotrackingDescription: UILabel!
    
    @IBOutlet weak var viewPinCode: UIView!
    @IBOutlet weak var lblPinCodeTitle: UILabel!
    @IBOutlet weak var lblPinCodeDescription: UILabel!
    
    internal lazy var selectedViews: [UIView] = []
    internal lazy var defaultColor: UIColor = UIColor.JGGGreen
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapBefore = UITapGestureRecognizer(target: self, action: #selector(onPressReportType(_:)))
        viewBeforeAndAfterPhoto.addGestureRecognizer(tapBefore)
        
        let tapGeotracking = UITapGestureRecognizer(target: self, action: #selector(onPressReportType(_:)))
        viewGeotracking.addGestureRecognizer(tapGeotracking)

        let tapPinCode = UITapGestureRecognizer(target: self, action: #selector(onPressReportType(_:)))
        viewPinCode.addGestureRecognizer(tapPinCode)

        resetButtons()
    }
    
    internal func resetButtons() {
        for label in [lblBeforeTitle, lblGeotrackingTitle, lblPinCodeTitle] {
            label?.textColor = defaultColor
            label?.tag = 120
        }
        for v in [viewBeforeAndAfterPhoto, viewGeotracking, viewPinCode] {
            v?.borderColor = defaultColor
            v?.borderWidth = 1
            v?.backgroundColor = UIColor.JGGGrey5
        }
    }

    @objc internal func onPressReportType(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            if let index = selectedViews.index(of: view) {
                view.borderColor = defaultColor
                view.borderWidth = 1
                view.backgroundColor = UIColor.JGGGrey5
                (view.viewWithTag(120) as? UILabel)?.textColor = defaultColor
                selectedViews.remove(at: index)
            } else {
                view.borderColor = nil
                view.borderWidth = 0
                view.backgroundColor = UIColor.JGGYellow
                (view.viewWithTag(120) as? UILabel)?.textColor = UIColor.JGGBlack
                selectedViews.append(view)
            }
        }
    }

    override func onPressedNext(_ sender: UIButton) {
        super.onPressedNext(sender)
        if let parentVC = parent as? JGGEditJobStepRootVC {
            parentVC.gotoSummaryVC()
        }
    }
}
