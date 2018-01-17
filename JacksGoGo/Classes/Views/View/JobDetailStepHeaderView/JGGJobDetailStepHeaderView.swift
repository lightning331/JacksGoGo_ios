//
//  JGGJobDetailStepHeaderView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGJobDetailStepHeaderView: UIView {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var line1: JGGJobDetailStepLineImageView!
    @IBOutlet weak var line2: JGGJobDetailStepLineImageView!
    @IBOutlet weak var line3: JGGJobDetailStepLineImageView!
    
    @IBOutlet weak var btnFirst: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    @IBOutlet weak var btnThird: UIButton!
    @IBOutlet weak var btnFourth: UIButton!
    
    var currentStep: Int = 0
    
    
    var delegate: JGGAppointmentDetailStepHeaderViewDelegate?
    
    internal var isCompleteFirst: Bool = false
    internal var isCompleteSecond: Bool = false
    internal var isCompleteThird: Bool = false
    internal var isCompleteFourth: Bool = false
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setCompletedStep(describe: Bool, price: Bool, time: Bool, address: Bool) -> Void {
        btnFirst.setTitle(LocalizedString("Describe"), for: .normal)
        btnSecond.setTitle(LocalizedString("Price"), for: .normal)
        btnThird.setTitle(LocalizedString("Time"), for: .normal)
        btnFourth.setTitle(LocalizedString("Address"), for: .normal)

        setCompletedStep(first: describe, second: price, third: time, fourth: address)

    }
    
    func setCompletedStep(describe: Bool, time: Bool, address: Bool, report: Bool) -> Void {
        btnFirst.setTitle(LocalizedString("Describe"), for: .normal)
        btnSecond.setTitle(LocalizedString("Time"), for: .normal)
        btnThird.setTitle(LocalizedString("Address"), for: .normal)
        btnFourth.setTitle(LocalizedString("Report"), for: .normal)

        setCompletedStep(first: describe, second: time, third: address, fourth: report)

    }
    
    func setCompletedStep(first: Bool, second: Bool, third: Bool, fourth: Bool) -> Void {
        
        setIcon(button: btnFirst,   isCompletion: first)
        setIcon(button: btnSecond,  isCompletion: second)
        setIcon(button: btnThird,   isCompletion: third)
        setIcon(button: btnFourth,  isCompletion: fourth)
        
        line1.setCompletion(second)
        line2.setCompletion(third)
        line3.setCompletion(fourth)

        self.isCompleteFirst = first
        self.isCompleteSecond = second
        self.isCompleteThird = third
        self.isCompleteFourth = fourth
        
        btnFirst.isEnabled = true
        selectButton(btnFirst)
    }
    
    internal func setIcon(button: UIButton, isCompletion: Bool) {
        if isCompletion {
            button.setImage(UIImage(named: "counter_greytick"), for: .normal)
            button.setImage(UIImage(named: "counter_greentick"), for: .selected)
            button.isEnabled = true
        } else {
            button.setImage(UIImage(named: "counter_grey"), for: .normal)
            button.setImage(UIImage(named: "counter_greenactive"), for: .selected)
            button.isEnabled = false
        }
    }
    
    internal func selectButton(_ button: UIButton) {
        for b in [btnFirst, btnSecond, btnThird, btnFourth] {
            if b == button {
                b?.isSelected = true
                if b == btnFirst {
                    currentStep = 0
                    
                    line1.setCompletion(isCompleteSecond)
                    line2.setCompletion(isCompleteThird)
                    line3.setCompletion(isCompleteFourth)

                } else if b == btnSecond {
                    currentStep = 1
                    
                    line1.setCompletion()
                    line2.setCompletion(isCompleteThird)
                    line3.setCompletion(isCompleteFourth)

                } else if b == btnThird {
                    currentStep = 2
                    
                    line1.setCompletion()
                    line2.setCompletion()
                    line3.setCompletion(isCompleteFourth)

                } else if b == btnFourth {
                    currentStep = 3

                    line1.setCompletion()
                    line2.setCompletion()
                    line3.setCompletion()

                } else {
                    currentStep = -1
                }
                self.delegate?.jobDetailStep(selected: currentStep)
            } else {
                b?.isSelected = false
            }
        }
    }
    
    @IBAction func onPressStep(_ button: UIButton) {
        selectButton(button)
    }
    
    func completeFirstStep(_ completion: Bool = true) -> Void {
        setIcon(button: btnFirst, isCompletion: completion)
        isCompleteFirst = true
    }
    
    func completeSecondStep(_ completion: Bool = true) -> Void {
        setIcon(button: btnSecond, isCompletion: completion)
        isCompleteSecond = true
    }
    
    func completeThirdStep(_ completion: Bool = true) -> Void {
        setIcon(button: btnThird, isCompletion: completion)
        isCompleteThird = true
    }
    
    func completeFourthStep(_ completion: Bool = true) -> Void {
        setIcon(button: btnFourth, isCompletion: completion)
        isCompleteFourth = true
    }
    
    func completeCurrentStep() -> Void {
        switch currentStep {
        case 0:
            completeFirstStep()
            break
        case 1:
            completeSecondStep()
            break
        case 2:
            completeThirdStep()
            break
        case 3:
            completeFourthStep()
            break
        default:
            break
        }
    }
    
    func nextStep() -> Void {
        switch currentStep {
        case 0:
            btnSecond.isEnabled = true
            selectButton(btnSecond)
            break
        case 1:
            btnThird.isEnabled = true
            selectButton(btnThird)
            break
        case 2:
            btnFourth.isEnabled = true
            selectButton(btnFourth)
            break
        case 3:
            
            break
        default:
            break
        }
    }
    
    func selectStep(index: Int) {
        switch index {
        case 0:
            selectButton(btnFirst)
            break
        case 1:
            selectButton(btnSecond)
            break
        case 2:
            selectButton(btnThird)
            break
        case 3:
            selectButton(btnFourth)
            break
        default:
            break
        }
    }
}

protocol JGGAppointmentDetailStepHeaderViewDelegate {
    func jobDetailStep(selected: Int) -> Void
    func jobDetailStepWillGotoNext(_ nextIndex: Int) -> Bool
}

extension JGGAppointmentDetailStepHeaderViewDelegate {
    func jobDetailStep(selected: Int) -> Void { }
    func jobDetailStepWillGotoNext(_ nextIndex: Int) -> Bool { return true }
}
