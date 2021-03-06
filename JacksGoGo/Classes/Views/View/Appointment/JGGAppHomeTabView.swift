//
//  JGGAppHomeTabView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

public enum AppointmentTabButton {
    case pending
    case confirmed
    case history
    case filter
}

class JGGAppHomeTabView: UIView {

    @IBOutlet weak var viewPending: UIView!
    @IBOutlet weak var btnPending: UIButton!
    @IBOutlet weak var viewPendingDot: UIView!
    @IBOutlet weak var viewPendingBadge: UIView!
    @IBOutlet weak var lblPendingBadge: UILabel!
    
    @IBOutlet weak var viewConfirmed: UIView!
    @IBOutlet weak var btnConfirmed: UIButton!
    @IBOutlet weak var viewConfirmedDot: UIView!
    @IBOutlet weak var viewConfirmedBadge: UIView!
    @IBOutlet weak var lblConfirmedBadge: UILabel!

    @IBOutlet weak var viewHistory: UIView!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var viewHistoryDot: UIView!
    
    @IBOutlet weak var btnFilter: UIButton!
    
    var delegate: JGGAppHomeTabViewDelegate?
    
    var pendingBadge: Int {
        set {
            _pendingBadge = newValue
            viewPendingBadge.isHidden = (newValue == 0)
        }
        get {
            return _pendingBadge
        }
    }
    
    var confirmedBadge: Int {
        set {
            _confirmedBadge = newValue
            viewConfirmedBadge.isHidden = (newValue == 0)
        }
        get {
            return _confirmedBadge
        }
    }
    
    fileprivate var selectedTabButton: UIButton!
    fileprivate var _pendingBadge: Int = 0
    fileprivate var _confirmedBadge: Int = 0

    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedTabButton = self.btnPending;
        
        btnPending.setTitleColor(UIColor.JGGOrange, for: .normal)
        viewPendingDot.isHidden = false

        btnConfirmed.setTitleColor(UIColor.JGGBlack, for: .normal)
        viewConfirmedDot.isHidden = true
        
        btnHistory.setTitleColor(UIColor.JGGBlack, for: .normal)
        viewHistoryDot.isHidden = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    }

    @IBAction func onPressButton(_ sender: UIButton) {

        if selectedTabButton == sender {
            return
        }
        if sender == btnFilter {
            delegate?.appointmentHomeTabView(self, selectedButton: .filter)
        } else {
            
            viewPendingDot.isHidden = true
            viewConfirmedDot.isHidden = true
            viewHistoryDot.isHidden = true
            
            btnPending.setTitleColor(UIColor.JGGBlack, for: .normal)
            btnConfirmed.setTitleColor(UIColor.JGGBlack, for: .normal)
            btnHistory.setTitleColor(UIColor.JGGBlack, for: .normal)

            if sender == btnPending {
                delegate?.appointmentHomeTabView(self, selectedButton: .pending)
                btnPending.setTitleColor(UIColor.JGGOrange, for: .normal)
                viewPendingDot.isHidden = false
            }
            else if sender == btnConfirmed {
                delegate?.appointmentHomeTabView(self, selectedButton: .confirmed)
                btnConfirmed.setTitleColor(UIColor.JGGOrange, for: .normal)
                viewConfirmedDot.isHidden = false
            }
            else if sender == btnHistory {
                delegate?.appointmentHomeTabView(self, selectedButton: .history)
                btnHistory.setTitleColor(UIColor.JGGOrange, for: .normal)
                viewHistoryDot.isHidden = false
            }
            selectedTabButton = sender
        }
    }
    
}

protocol JGGAppHomeTabViewDelegate {
    func appointmentHomeTabView(_ view: JGGAppHomeTabView, selectedButton: AppointmentTabButton)
}
