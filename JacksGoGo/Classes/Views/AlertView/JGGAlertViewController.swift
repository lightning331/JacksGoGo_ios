//
//  JGGAlertViewController.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/7/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit
import MZFormSheetPresentationController

public enum JGGAlertColorSchema {
    case red
    case green
    case cyan
}

public typealias JGGAlertButtonBlock = (() -> Void)

class JGGAlertViewController: UIViewController {

    // MARK: - Class methods to show alert
    static func show(title: String?,
                     message: String?,
                     colorSchema: JGGAlertColorSchema = .green,
                     okButtonTitle: String = "OK",
                     okAction: JGGAlertButtonBlock? = nil,
                     cancelButtonTitle: String? = "Cancel",
                     cancelAction: JGGAlertButtonBlock? = nil)
    {
        let topVC = UIApplication.shared.keyWindow?.rootViewController

        let alertVC = JGGAlertViewController(nibName: "JGGAlertViewController", bundle: nil)
            alertVC.alertTitle = title
            alertVC.alertMessage = message
            alertVC.colorSchema = colorSchema
            alertVC.okButtonTitle = okButtonTitle
            alertVC.okAction = okAction
            alertVC.cancelButtonTitle = cancelButtonTitle
            alertVC.cancelAction = cancelAction
            
        let mzformSheetVC = MZFormSheetPresentationViewController(contentViewController: alertVC)
            mzformSheetVC.contentViewControllerTransitionStyle = .bounce
            topVC?.present(mzformSheetVC, animated: true, completion: nil)
    }
    
    // MARK: - Properties
    var alertTitle: String?
    var alertMessage: String?
    var colorSchema: JGGAlertColorSchema = .green
    var okButtonTitle: String = "OK"
    var okAction: JGGAlertButtonBlock?
    var cancelButtonTitle: String?
    var cancelAction: JGGAlertButtonBlock?
    
    // MARK: UI Properties
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }

    private func initUI() {
        
        self.lblTitle.text = alertTitle
        self.lblMessage.text = alertMessage
        self.btnOK.setTitle(okButtonTitle, for: .normal)
        self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
        
        switch colorSchema {
        case .green:
            btnOK.backgroundColor = UIColor.JGGGreen
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            btnCancel.backgroundColor = UIColor.JGGGreen10Percent
            btnCancel.setTitleColor(UIColor.JGGGreen, for: .normal)
            break
        case .cyan:
            btnOK.backgroundColor = UIColor.JGGCyan
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            btnCancel.backgroundColor = UIColor.JGGCyan10Percent
            btnCancel.setTitleColor(UIColor.JGGCyan, for: .normal)
            break
        case .red:
            btnOK.backgroundColor = UIColor.JGGRed
            btnOK.setTitleColor(UIColor.JGGWhite, for: .normal)
            btnCancel.backgroundColor = UIColor.JGGGreen10Percent
            btnCancel.setTitleColor(UIColor.JGGGreen, for: .normal)
            break
        }
        
        if cancelButtonTitle == nil {
            btnCancel.removeConstraints(btnCancel.constraints)
            btnCancel.isHidden = true
            btnOK.removeConstraints(btnOK.constraints)
            btnOK.snp.makeConstraints({ (maker) in
                maker.left.top.right.bottom.equalToSuperview()
            })
        }
    }
    
    @IBAction func onPressedCancel(_ sender: Any) {
        self.dismiss(animated: true) {
            self.cancelAction?()
        }
    }
    
    @IBAction func onPressedOK(_ sender: Any) {
        self.dismiss(animated: true) {
            self.okAction?()
        }
    }
    
}

extension JGGAlertViewController: MZFormSheetPresentationContentSizing {
    
    func shouldUseContentViewFrame(for presentationController: MZFormSheetPresentationController!) -> Bool {
        return true
    }
    
    func contentViewFrame(for presentationController: MZFormSheetPresentationController!, currentFrame: CGRect) -> CGRect {
        let screenSize = UIScreen.main.bounds.size
        var titleHeight: CGFloat = 10
        if let alertTitle = alertTitle {
            titleHeight = alertTitle.height(withConstrainedWidth: screenSize.width - 90, font: lblTitle.font)
        }
        var messageHeight: CGFloat = 10
        if let alertMessage = alertMessage {
            messageHeight = alertMessage.height(withConstrainedWidth: screenSize.width - 80, font: lblMessage.font)
        }
        let resultFrameSize = CGSize(width: screenSize.width - 30,
                                     height: 120 + titleHeight + messageHeight)
        let resultOrigin = CGPoint(x: currentFrame.origin.x,
                                   y: (screenSize.height - resultFrameSize.height) / 2)
        return CGRect(origin: resultOrigin, size: resultFrameSize)
    }
    
}
