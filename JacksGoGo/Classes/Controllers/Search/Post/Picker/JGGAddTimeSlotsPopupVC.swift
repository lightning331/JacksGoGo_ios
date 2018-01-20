//
//  JGGAddTimeSlotsPopupVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MZFormSheetPresentationController
import Toaster

class JGGAddTimeSlotsPopupVC: JGGPopupBaseVC {

    @IBOutlet weak var btnStartTimeHourIncrease: UIButton!
    @IBOutlet weak var btnStartTimeHourDecrease: UIButton!
    @IBOutlet weak var btnStartTimeMinuteIncrease: UIButton!
    @IBOutlet weak var btnStartTimeMinuteDecrease: UIButton!
    @IBOutlet weak var txtStartTimeHour: UITextField!
    @IBOutlet weak var txtStartTimeMinute: UITextField!
    @IBOutlet weak var btnStartTimeAM: UIButton!
    @IBOutlet weak var btnStartTimePM: UIButton!
    
    @IBOutlet weak var btnSetEndTime: UIButton!
    @IBOutlet weak var viewEndTimeBox: UIView!
    @IBOutlet weak var btnEndTimeClose: UIButton!
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
    
    var doneButtonTitle: String?
    var showEndTime: Bool = true
    var selectedStartTime: Date?
    var selectedEndTime: Date?
    var selectTimeHandler: ((Date?, Date?, Int?) -> Void)?
    
    // MARK: Private properties
    fileprivate var startHour: Int = 0
    fileprivate var startMinute: Int = 0
    fileprivate var startAM: Bool = true
    fileprivate var endHour: Int = 0
    fileprivate var endMinute: Int = 0
    fileprivate var endAM: Bool = true
    fileprivate var numberOfPax: Int = 1
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtStartTimeHour.text = "12"
        txtEndTimeHour.text = "12"
        
        btnStartTimeAM.isSelected = true
        btnStartTimePM.isSelected = false
        btnEndTimeAM.isSelected = true
        btnEndTimePM.isSelected = false
        
        viewNumberOfPax.isHidden = true
        if showEndTime || selectedEndTime != nil {
            btnSetEndTime.isHidden = true
            btnEndTimeClose.isHidden = false
            viewEndTimeBox.isHidden = false
        } else {
            btnSetEndTime.isHidden = false
            btnEndTimeClose.isHidden = false
            viewEndTimeBox.isHidden = true
        }
        if let doneButtonTitle = doneButtonTitle {
            btnAdd.setTitle(doneButtonTitle, for: .normal)
        }
        
        func parseTime(_ time: Date?, textFieldHour: UITextField, textFieldMinute: UITextField, buttonPeriodAM: UIButton, buttonPeriodPM: UIButton) {
            if let time = time {
                var isPeriod: Bool = true
                var hour = time.component(.hour)!
                if hour == 12 {
                    isPeriod = false
                }
                else if hour == 0 {
                    hour = 12
                }
                else if hour > 12 {
                    hour -= 12
                    isPeriod = false
                }
                let minute = time.component(.minute)!
                textFieldHour.text = String(format: "%02d", hour)
                textFieldMinute.text = String(format: "%02d", minute)
                buttonPeriodAM.isSelected = isPeriod
                buttonPeriodPM.isSelected = !isPeriod
            }
        }
        
        parseTime(selectedStartTime,
                  textFieldHour: txtStartTimeHour,
                  textFieldMinute: txtStartTimeMinute,
                  buttonPeriodAM: btnStartTimeAM,
                  buttonPeriodPM: btnStartTimePM)

        parseTime(selectedEndTime,
                  textFieldHour: txtEndTimeHour,
                  textFieldMinute: txtEndTimeMinute,
                  buttonPeriodAM: btnEndTimeAM,
                  buttonPeriodPM: btnEndTimePM)
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
            startHour = 12
        } else if startHour > 12 {
            startHour = 1
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
            endHour = 12
        } else if endHour > 12 {
            endHour = 1
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
    
    @IBAction private func onPressedSetEndTime(_ sender: UIButton) {
        btnSetEndTime.isHidden = true
        btnEndTimeClose.isHidden = false
        viewEndTimeBox.isHidden = false
    }
    
    @IBAction private func onPressedCloseEndTime(_ sender: UIButton) {
        btnSetEndTime.isHidden = false
        viewEndTimeBox.isHidden = true
    }
    
    
    @IBAction func onPressedCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressedAdd(_ sender: UIButton) {
        
        if let selectTimeHandler = selectTimeHandler {
            let startTime = Date(hour: Int(txtStartTimeHour.text!)!,
                                 minute: Int(txtStartTimeMinute.text!)!,
                                 isAM: btnStartTimeAM.isSelected)
            var endTime: Date? = nil
            if viewEndTimeBox.isHidden == false {
                endTime = Date(hour: Int(txtEndTimeHour.text!)!,
                               minute: Int(txtEndTimeMinute.text!)!,
                               isAM: btnEndTimeAM.isSelected)
                if let startTime = startTime, let endTime = endTime,
                   startTime.compare(.isLater(than: endTime))
                {
                    Toast(text: LocalizedString("Please set end time later than start time."),
                          delay: 0,
                          duration: 5).show()
                    return
                }
            }
            selectTimeHandler(startTime, endTime, nil)
        }
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
