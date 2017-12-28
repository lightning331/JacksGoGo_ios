
//
//  JGGJobPostStepHeaderView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/26/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGJobPostStepHeaderView: JGGJobDetailStepHeaderView {

    @IBOutlet weak var line4: JGGJobDetailStepLineImageView!

    @IBOutlet weak var btnFifth: UIButton!
    
    internal var isCompleteFifth: Bool = false

    func setCompletedStep(describe: Bool, time: Bool, address: Bool, budget: Bool, report: Bool) -> Void {
        btnFirst.setTitle(LocalizedString("Describe"), for: .normal)
        btnSecond.setTitle(LocalizedString("Time"), for: .normal)
        btnThird.setTitle(LocalizedString("Address"), for: .normal)
        btnFourth.setTitle(LocalizedString("Budget"), for: .normal)
        btnFifth.setTitle(LocalizedString("Report"), for: .normal)
        
        setCompletedStep(first: describe, second: time, third: address, fourth: budget, fifth: report)
    }
    
    func setCompletedStep(first: Bool, second: Bool, third: Bool, fourth: Bool, fifth: Bool) {
        super.setCompletedStep(first: first, second: second, third: third, fourth: fourth)
        
        setIcon(button: btnFifth,  isCompletion: fifth)
        
        line4.setCompletion(fifth)
        
        self.isCompleteFifth = fifth

    }
    
    override func selectButton(_ button: UIButton) {
        for b in [btnFirst, btnSecond, btnThird, btnFourth, btnFifth] {
            if b == button {
                b?.isSelected = true
                if b == btnFirst {
                    currentStep = 0
                    
                    line1.setCompletion(isCompleteSecond)
                    line2.setCompletion(isCompleteThird)
                    line3.setCompletion(isCompleteFourth)
                    line4.setCompletion(isCompleteFifth)
                    
                } else if b == btnSecond {
                    currentStep = 1
                    
                    line1.setCompletion()
                    line2.setCompletion(isCompleteThird)
                    line3.setCompletion(isCompleteFourth)
                    line4.setCompletion(isCompleteFifth)
                    
                } else if b == btnThird {
                    currentStep = 2
                    
                    line1.setCompletion()
                    line2.setCompletion()
                    line3.setCompletion(isCompleteFourth)
                    line4.setCompletion(isCompleteFifth)
                    
                } else if b == btnFourth {
                    currentStep = 3
                    
                    line1.setCompletion()
                    line2.setCompletion()
                    line3.setCompletion()
                    line4.setCompletion(isCompleteFifth)
                    
                } else if b == btnFifth {
                    currentStep = 4
                    
                    line1.setCompletion()
                    line2.setCompletion()
                    line3.setCompletion()
                    line4.setCompletion()
                    
                } else {
                    currentStep = -1
                }
                self.delegate?.jobDetailStep(selected: currentStep)
            } else {
                b?.isSelected = false
            }
        }

    }

    func completeFifthStep(_ completion: Bool = true) -> Void {
        setIcon(button: btnFifth, isCompletion: completion)
        isCompleteFifth = true
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
    
    override func completeCurrentStep() {
        if currentStep == 4 {
            completeFifthStep()
        } else {
            super.completeCurrentStep()
        }
    }
    
    override func nextStep() {
        if currentStep == 3 {
            btnFifth.isEnabled = true
            selectButton(btnFifth)
        } else {
            super.nextStep()
        }
    }
}
