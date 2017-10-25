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
    
    fileprivate var selectedTabButton: UIButton!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedTabButton = self.btnPending;
        
        btnPending.setTitleColor(UIColor.JGGBlack, for: .normal)
        btnPending.setTitleColor(UIColor.JGGOrange, for: .selected)
        btnConfirmed.setTitleColor(UIColor.JGGBlack, for: .normal)
        btnConfirmed.setTitleColor(UIColor.JGGOrange, for: .selected)
        btnHistory.setTitleColor(UIColor.JGGBlack, for: .normal)
        btnHistory.setTitleColor(UIColor.JGGOrange, for: .selected)
    }
    
    @IBAction func onPressButton(_ sender: UIButton) {
        viewPendingDot.isHidden = true
        viewConfirmedDot.isHidden = true
        viewHistoryDot.isHidden = true
        btnPending.isSelected = false
        btnConfirmed.isSelected = false
        btnHistory.isSelected = false
        
        if sender == btnPending {
            delegate?.appointmentHomeTabView(self, selectedButton: .pending)
            btnPending.isSelected = true
            viewPendingDot.isHidden = false
        }
        else if sender == btnConfirmed {
            delegate?.appointmentHomeTabView(self, selectedButton: .confirmed)
            btnConfirmed.isSelected = true
            viewConfirmedDot.isHidden = false
        }
        else if sender == btnHistory {
            delegate?.appointmentHomeTabView(self, selectedButton: .history)
            btnConfirmed.isSelected = true
            viewHistoryDot.isHidden = false
        }
        else if sender == btnFilter {
            delegate?.appointmentHomeTabView(self, selectedButton: .filter)
        }
    }
}

protocol JGGAppHomeTabViewDelegate {
    func appointmentHomeTabView(_ view: JGGAppHomeTabView, selectedButton: AppointmentTabButton)
}
