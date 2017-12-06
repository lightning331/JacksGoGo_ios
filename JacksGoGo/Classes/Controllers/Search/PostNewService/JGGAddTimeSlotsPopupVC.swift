//
//  JGGAddTimeSlotsPopupVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MZFormSheetPresentationController

class JGGAddTimeSlotsPopupVC: JGGPopupBaseVC {

    @IBOutlet weak var btnStartTimeHourIncrease: UIButton!
    @IBOutlet weak var btnStartTimeHourDecrease: UIButton!
    @IBOutlet weak var btnStartTimeMinuteIncrease: UIButton!
    @IBOutlet weak var btnStartTimeMinuteDecrease: UIButton!
    @IBOutlet weak var txtStartTimeHour: UITextField!
    @IBOutlet weak var txtStartTimeMinute: UITextField!
    @IBOutlet weak var btnStartTimeAM: UIButton!
    @IBOutlet weak var btnStartTimePM: UIButton!
    
    @IBOutlet weak var btnEndTimeHourIncrease: UIButton!
    @IBOutlet weak var btnEndTimeHourDecrease: UIButton!
    @IBOutlet weak var btnEndTimeMinuteIncrease: UIButton!
    @IBOutlet weak var btnEndTimeMinuteDecrease: UIButton!
    @IBOutlet weak var txtEndTimeHour: UITextField!
    @IBOutlet weak var txtEndTimeMinute: UITextField!
    @IBOutlet weak var btnEndTimeAM: UIButton!
    @IBOutlet weak var btnEndTimePM: UIButton!

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var viewNumberOfPax: UIView!
    @IBOutlet weak var btnPaxIncrease: UIButton!
    @IBOutlet weak var btnPaxDecrease: UIButton!
    @IBOutlet weak var txtNumberOfPax: UITextField!
    
    fileprivate var startHour: Int = 0
    fileprivate var startMinute: Int = 0
    fileprivate var startAM: Bool = true
    fileprivate var endHour: Int = 0
    fileprivate var endMinute: Int = 0
    fileprivate var endAM: Bool = true
    fileprivate var numberOfPax: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnStartTimeAM.isSelected = true
        btnStartTimePM.isSelected = false
        btnEndTimeAM.isSelected = true
        btnEndTimePM.isSelected = false
        
    }
    
    override func contentViewFrame(for presentationController: MZFormSheetPresentationController!, currentFrame: CGRect) -> CGRect {
        var frame = UIScreen.main.bounds.insetBy(dx: 10, dy: 50)
        frame.size.height = 450
        return frame
    }
    
    @IBAction func onPressedChangeTime(_ sender: UIButton) {
        if sender == btnStartTimeHourIncrease {
            startHour += 1
        } else if sender == btnStartTimeHourDecrease {
            startHour -= 1
        } else if sender == btnStartTimeMinuteIncrease {
            startMinute += 15
        } else if sender == btnStartTimeMinuteDecrease {
            startMinute -= 15
        } else if sender == btnStartTimeAM {
            btnStartTimeAM.isSelected = !btnStartTimeAM.isSelected
            btnStartTimePM.isSelected = !btnStartTimeAM.isSelected
        } else if sender == btnStartTimePM {
            btnStartTimePM.isSelected = !btnStartTimePM.isSelected
            btnStartTimeAM.isSelected = !btnStartTimePM.isSelected
        }
        
        else if sender == btnEndTimeHourIncrease {
            endHour += 1
        } else if sender == btnEndTimeHourDecrease {
            endHour -= 1
        } else if sender == btnEndTimeMinuteIncrease {
            endMinute += 15
        } else if sender == btnEndTimeMinuteDecrease {
            endMinute -= 15
        } else if sender == btnEndTimeAM {
            btnEndTimeAM.isSelected = !btnEndTimeAM.isSelected
            btnEndTimePM.isSelected = !btnEndTimeAM.isSelected
        } else if sender == btnEndTimePM {
            btnEndTimePM.isSelected = !btnEndTimePM.isSelected
            btnEndTimeAM.isSelected = !btnEndTimePM.isSelected
        }
        
        startAM = btnStartTimeAM.isSelected
        if startHour < 1 {
//            startHour = 12
//            startAM = !startAM
            startHour = 1
        } else if startHour > 12 {
//            startHour = 1
//            startAM = !startAM
            startHour = 12
        }
        if startMinute < 0 {
            startMinute = 0
        } else if startMinute >= 45 {
            startMinute = 45
        }
        txtStartTimeHour.text = String(format: "%02d", startHour)
        txtStartTimeMinute.text = String(format: "%02d", startMinute)
        
        endAM = btnEndTimeAM.isSelected
        if endHour < 1 {
            endHour = 1
        } else if endHour > 12 {
            endHour = 12
        }
        if endMinute < 0 {
            endMinute = 0
        } else if endMinute >= 45 {
            endMinute = 45
        }
        txtEndTimeHour.text = String(format: "%02d", endHour)
        txtEndTimeMinute.text = String(format: "%02d", endMinute)

    }
    
    @IBAction func onPressedChangeNumberOfPax(_ sender: UIButton) {
        if sender == btnPaxIncrease {
            numberOfPax += 1
        } else if sender == btnPaxDecrease {
            numberOfPax -= 1
        }
        if numberOfPax < 1 {
            numberOfPax = 1
        }
        txtNumberOfPax.text = String(numberOfPax)
    }
    
    @IBAction func onPressedCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressedAdd(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
