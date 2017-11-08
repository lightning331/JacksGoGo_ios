//
//  JGGJobDetailStepHeaderView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

public enum JobDetailStep {
    case describe
    case time
    case address
    case report
    case none
}

class JGGJobDetailStepHeaderView: UIView {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var line1DescribeAndTime: JGGJobDetailStepLineImageView!
    @IBOutlet weak var line2TimeAndAddress: JGGJobDetailStepLineImageView!
    @IBOutlet weak var line3AddressAndReport: JGGJobDetailStepLineImageView!
    
    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    
    var currentStep: JobDetailStep = .describe
    
    var delegate: JGGJobDetailStepHeaderViewDelegate?
    
    fileprivate var isCompleteTime: Bool = false
    fileprivate var isCompleteAddress: Bool = false
    fileprivate var isCompleteReport: Bool = false
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectButton(btnDescribe)
    }
    
    func setCompletedStep(describe: Bool, time: Bool, address: Bool, report: Bool) -> Void {
        
        setIcon(button: btnDescribe, isCompletion: describe)
        setIcon(button: btnTime,     isCompletion: time)
        setIcon(button: btnAddress,  isCompletion: address)
        setIcon(button: btnReport,   isCompletion: report)
        
        line1DescribeAndTime.setCompletion(time)
        line2TimeAndAddress.setCompletion(time)
        line3AddressAndReport.setCompletion(time)

        self.isCompleteTime = time
        self.isCompleteAddress = address
        self.isCompleteReport = report
    }

    fileprivate func setIcon(button: UIButton, isCompletion: Bool) {
        if isCompletion {
            button.setImage(UIImage(named: "counter_greytick"), for: .normal)
            button.setImage(UIImage(named: "counter_greentick"), for: .selected)
        } else {
            button.setImage(UIImage(named: "counter_grey"), for: .normal)
            button.setImage(UIImage(named: "counter_greenactive"), for: .selected)
        }
    }
    
    fileprivate func selectButton(_ button: UIButton) {
        for b in [btnDescribe, btnTime, btnAddress, btnReport] {
            if b == button {
                b?.isSelected = true
                if b == btnDescribe {
                    currentStep = .describe
                    line1DescribeAndTime.setCompletion(isCompleteTime)
                    line2TimeAndAddress.setCompletion(isCompleteAddress)
                    line3AddressAndReport.setCompletion(isCompleteReport)

                } else if b == btnTime {
                    currentStep = .time
                    
                    line1DescribeAndTime.setCompletion()
                    line2TimeAndAddress.setCompletion(isCompleteAddress)
                    line3AddressAndReport.setCompletion(isCompleteReport)

                } else if b == btnAddress {
                    currentStep = .address
                    
                    line1DescribeAndTime.setCompletion()
                    line2TimeAndAddress.setCompletion()
                    line3AddressAndReport.setCompletion(isCompleteReport)

                } else if b == btnReport {
                    currentStep = .report
                    
                    line1DescribeAndTime.setCompletion()
                    line2TimeAndAddress.setCompletion()
                    line3AddressAndReport.setCompletion()

                } else {
                    currentStep = .none
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
    
}

protocol JGGJobDetailStepHeaderViewDelegate {
    func jobDetailStep(selected: JobDetailStep) -> Void
}
