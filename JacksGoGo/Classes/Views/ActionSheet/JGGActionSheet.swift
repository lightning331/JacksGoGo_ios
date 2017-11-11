//
//  JGGActionSheet.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit


public enum JGGActionSheetType {
    case confirm      // Description and one button
    case interaction  // Two button to select only one
    
}

public typealias JGGActionSheetButtonClosure = (() -> Void)

open class JGGActionSheet: UIView {

    fileprivate var contentView: JGGActionSheetPromptBaseView!
    fileprivate var type: JGGActionSheetType = .interaction
    
    // MARK: - Class methods
    
    open static func showInteraction(title: String?,
                                     primaryButtonTitle: String?,
                                     secondaryButtonTitle: String?,
                                     cancelButtonTitle: String?,
                                     primaryButtonAction: JGGActionSheetButtonClosure?,
                                     secondaryButtonAction: JGGActionSheetButtonClosure?,
                                     cancelButtonAction: JGGActionSheetButtonClosure?)
    {
        let actionSheet = JGGActionSheet(type: .interaction)
        actionSheet.title = title
        actionSheet.primaryButtonTitle = primaryButtonTitle
        actionSheet.secondaryButtonTitle = secondaryButtonTitle
        actionSheet.cancelButtonTitle = cancelButtonTitle
        actionSheet.primaryButtonAction = primaryButtonAction
        actionSheet.secondaryButtonAction = secondaryButtonAction
        actionSheet.cancelButtonAction = cancelButtonAction
        actionSheet.show()
    }
    
    open static func showConfirm(title: String?,
                                primaryButtonTitle: String?,
                                cancelButtonTitle: String?,
                                confirmTitle: String?,
                                confirmContentTitle: String?,
                                confirmContentValue: String?,
                                primaryButtonAction: JGGActionSheetButtonClosure?,
                                cancelButtonAction: JGGActionSheetButtonClosure?)
    {
        let actionSheet = JGGActionSheet(type: .interaction)
        actionSheet.title = title
        actionSheet.primaryButtonTitle = primaryButtonTitle
        actionSheet.cancelButtonTitle = cancelButtonTitle
        actionSheet.confirmTitle = confirmTitle
        actionSheet.confirmContentTitle = confirmContentTitle
        actionSheet.confirmContentValue = confirmContentValue
        actionSheet.primaryButtonAction = primaryButtonAction
        actionSheet.cancelButtonAction = cancelButtonAction
        actionSheet.show()
    }
    
    // MARK: - Structures
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    init(type: JGGActionSheetType) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        if type == .confirm {
            contentView = UINib(nibName: "JGGActionSheet", bundle: nil).instantiate(withOwner: self, options: nil)[1] as! JGGActionSheetConfirmView
        }
        else if type == .interaction {
            contentView = UINib(nibName: "JGGActionSheet", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! JGGActionSheetInteractionView
            (contentView as! JGGActionSheetInteractionView).btnSecondary.addTarget(self, action: #selector(onPressedSecondaryButton(_:)), for: .touchUpInside)
        } else {
            return
        }
        self.type = type
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.height.equalTo(260)
            maker.bottom.equalToSuperview().offset(260)
        }
        contentView.btnCancel.addTarget(self, action: #selector(onPressedCancelButton(_:)), for: .touchUpInside)
        contentView.btnPrimary.addTarget(self, action: #selector(onPressedPrimaryButton(_:)), for: .touchUpInside)
        
    }
    
    // Internal methods
    var title: String? {
        get {
            return self.contentView.lblTitle.text
        }
        set {
            self.contentView.lblTitle.text = newValue
        }
    }
    
    var cancelButtonTitle: String? {
        get {
            return self.contentView.btnCancel.title(for: .normal)
        }
        set {
            return self.contentView.btnCancel.setTitle(newValue, for: .normal)
        }
    }
    
    var confirmTitle: String? {
        get {
            if self.type == .confirm {
                return (self.contentView as! JGGActionSheetConfirmView).lblConfirmTitle.text
            } else {
                return nil
            }
        }
        set {
            if self.type == .confirm {
                (self.contentView as! JGGActionSheetConfirmView).lblConfirmTitle.text = newValue
            }
        }
    }
    
    var confirmContentTitle: String? {
        get {
            if self.type == .confirm {
                return (self.contentView as! JGGActionSheetConfirmView).lblConfirmContentTitle.text
            } else {
                return nil
            }
        }
        set {
            if self.type == .confirm {
                (self.contentView as! JGGActionSheetConfirmView).lblConfirmContentTitle.text = newValue
            }
        }
    }
    
    var confirmContentValue: String? {
        get {
            if self.type == .confirm {
                return (self.contentView as! JGGActionSheetConfirmView).lblConfirmContentValue.text
            } else {
                return nil
            }
        }
        set {
            if self.type == .confirm {
                (self.contentView as! JGGActionSheetConfirmView).lblConfirmContentValue.text = newValue
            }
        }
    }
    
    var primaryButtonTitle: String? {
        get {
            return self.contentView.btnPrimary.title(for: .normal)
        }
        set {
            self.contentView.btnPrimary.setTitle(newValue, for: .normal)
        }
    }
    
    var secondaryButtonTitle: String? {
        get {
            if self.type == .confirm {
                return (self.contentView as! JGGActionSheetInteractionView).btnSecondary.title(for: .normal)
            } else {
                return nil
            }
        }
        set {
            if self.type == .confirm {
                (self.contentView as! JGGActionSheetInteractionView).btnSecondary.setTitle(newValue, for: .normal)
            }
        }
    }
    
    var cancelButtonAction: JGGActionSheetButtonClosure?
    var primaryButtonAction: JGGActionSheetButtonClosure?
    var secondaryButtonAction: JGGActionSheetButtonClosure?
    
    @objc fileprivate func onPressedCancelButton(_ sender: UIButton) {
        hideAnimation {
            self.cancelButtonAction?()
        }
    }
    
    @objc fileprivate func onPressedPrimaryButton(_ sender: UIButton) {
        hideAnimation {
            self.primaryButtonAction?()
        }
    }
    
    @objc fileprivate func onPressedSecondaryButton(_ sender: UIButton) {
        hideAnimation {
            self.secondaryButtonAction?()
        }
    }
    
    func show() -> Void {
        UIApplication.shared.keyWindow?.addSubview(self)
        self.perform(#selector(showAnimation(_:)), with: true, afterDelay: 0.1)
//        showAnimation(true)
        
//        UIApplication.shared.keyWindow?.addSubview(self)

    }
    
    @objc fileprivate func showAnimation(_ isAnimation: Bool) {
        self.contentView.snp.updateConstraints { (maker) in
            maker.bottom.equalToSuperview().offset(0)
        }
        self.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.6, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }) { (finished) in
            
        }

    }
    
    func hide() -> Void {
        hideAnimation(nil)
    }
    
    fileprivate func hideAnimation(_ completion: (() -> Void)?) {
        self.contentView.snp.updateConstraints { (maker) in
            maker.bottom.equalToSuperview().offset(260)
        }
        self.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
            completion?()
        }
    }
    
}

class JGGActionSheetPromptBaseView: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPrimary: UIButton!

}

class JGGActionSheetInteractionView: JGGActionSheetPromptBaseView {
    @IBOutlet weak var btnSecondary: UIButton!
    
}

class JGGActionSheetConfirmView: JGGActionSheetPromptBaseView {
    @IBOutlet weak var lblConfirmTitle: UILabel!
    @IBOutlet weak var lblConfirmContentTitle: UILabel!
    @IBOutlet weak var lblConfirmContentValue: UILabel!
    
}
