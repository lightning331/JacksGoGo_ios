//
//  JGGProposalStepHeaderView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/13/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProposalStepHeaderView: JGGJobDetailStepHeaderView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setCompletedStep(describe: Bool, bid: Bool, rescheduling: Bool, cancellation: Bool) -> Void {
        btnFirst.setTitle(LocalizedString("Describe"), for: .normal)
        btnSecond.setTitle(LocalizedString("Bid"), for: .normal)
        btnThird.setTitle(LocalizedString("Rescheduling"), for: .normal)
        btnFourth.setTitle(LocalizedString("Cancallation"), for: .normal)
        
        setCompletedStep(first: describe, second: bid, third: rescheduling, fourth: cancellation)
    }
    
    override func setIcon(button: UIButton, isCompletion: Bool) {
        if isCompletion {
            button.setImage(UIImage(named: "counter_greytick"), for: .normal)
            button.setImage(UIImage(named: "counter_cyantick"), for: .selected)
            button.isEnabled = true
        } else {
            button.setImage(UIImage(named: "counter_grey"), for: .normal)
            button.setImage(UIImage(named: "counter_cyanactive"), for: .selected)
            button.isEnabled = false
        }
        button.setTitleColor(UIColor.JGGCyan, for: .selected)
    }
}
