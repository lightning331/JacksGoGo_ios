//
//  JGGEditJobReportVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGEditJobReportVC: JGGEditJobBaseTableVC {

    @IBOutlet weak var viewBeforeAndAfterPhoto: UIView!
    @IBOutlet weak var lblBeforeTitle: UILabel!
    @IBOutlet weak var lblBeforeDescription: UILabel!
    
    @IBOutlet weak var viewGeotracking: UIView!
    @IBOutlet weak var lblGeotrackingTitle: UILabel!
    @IBOutlet weak var lblGeotrackingDescription: UILabel!
    
    @IBOutlet weak var viewPinCode: UIView!
    @IBOutlet weak var lblPinCodeTitle: UILabel!
    @IBOutlet weak var lblPinCodeDescription: UILabel!
    
    fileprivate var selectedView: UIView?
    
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
    
    fileprivate func resetButtons() {
        for label in [lblBeforeTitle, lblGeotrackingTitle, lblPinCodeTitle] {
            label?.textColor = UIColor.JGGGreen
        }
        for v in [viewBeforeAndAfterPhoto, viewGeotracking, viewPinCode] {
            v?.borderColor = UIColor.JGGGreen
            v?.borderWidth = 1
            v?.backgroundColor = UIColor.JGGGrey5
        }
    }

    @objc fileprivate func onPressReportType(_ sender: UITapGestureRecognizer) {
        resetButtons()
        if selectedView == sender.view {
            selectedView = nil
        } else {
            selectedView = sender.view
            selectedView?.borderColor = nil
            selectedView?.borderWidth = 0
            selectedView?.backgroundColor = UIColor.JGGYellow
            if selectedView == viewBeforeAndAfterPhoto {
                lblBeforeTitle.textColor = UIColor.JGGBlack
            } else if selectedView == viewGeotracking {
                lblGeotrackingTitle.textColor = UIColor.JGGBlack
            } else if selectedView == viewPinCode {
                lblPinCodeTitle.textColor = UIColor.JGGBlack
            }
        }
    }

}
