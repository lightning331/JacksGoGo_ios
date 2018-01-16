//
//  JGGPostJobTimeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster
import AFDateHelper

class JGGPostJobTimeVC: JGGPostAppointmentBaseTableVC {

    
    fileprivate var selectedTimeType: Int = 0  // 0: unselected, 1: one-time, 2: repeating
    fileprivate var selectedDate: Date?
    fileprivate var selectedStartTime: Date?
    fileprivate var selectedEndTime: Date?
    fileprivate var selectedMonthly: Bool?
    fileprivate lazy var selectedRepeatingDays: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.isHidden = false
    }
    
    override func onPressedNext(_ sender: UIButton) {
        var readyToNext: Bool = true
        if selectedTimeType == 0 {
            Toast(text: LocalizedString("Select a kind of job"), delay: 0, duration: 3).show()
            readyToNext = false
        } else {
            if selectedTimeType == 1 {
                if selectedDate == nil || (selectedStartTime == nil && selectedEndTime == nil) {
                    Toast(text: LocalizedString("Please set date and time."), delay: 0, duration: 3).show()
                    readyToNext = false
                }
            } else if selectedTimeType == 2 {
                if selectedMonthly == nil || selectedRepeatingDays.count == 0 {
                    Toast(text: LocalizedString("Please set dates for repeating."), delay: 0, duration: 3).show()
                    readyToNext = false
                }
            }
        }
        if readyToNext {
            super.onPressedNext(sender)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = self.selectedMonthly {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if selectedTimeType > 0 {
                return 2
            }
            return 1
        } else {
            return selectedRepeatingDays.count + 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeTypeCell") as! JGGPostJobTimeTypeCell
                cell.selectingHandler = { index in
                    self.selectedTimeType = index
                    self.tableView.reloadData()
                }
                return cell
            } else if indexPath.row == 1 {
                if selectedTimeType == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeOneTimeCell") as! JGGPostJobTimeOneTimeCell
                    cell.changedTypeHandler = {
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                    }
                    cell.dateTapHandler = {
                        self.showDatePopup(with: cell.btnDate)
                    }
                    cell.timeTapHandler =  {
                        self.showTimePopup(with: cell.btnTime)
                    }
                    return cell
                }
                else if selectedTimeType == 2 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeRepeatingCell") as! JGGPostJobTimeRepeatingCell
                    cell.changedTypeHandler = { isMonthly in
                        self.selectedMonthly = isMonthly
                        self.selectedRepeatingDays.removeAll()
                        self.tableView.reloadData()
                    }
                    return cell
                }
            }
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeRepeatingDayCell") as! JGGPostJobTimeRepeatingDayCell
            if indexPath.row < selectedRepeatingDays.count {
                cell.title = dayName(for: selectedRepeatingDays[indexPath.row])
                cell.clearHandler = {
                    self.selectedRepeatingDays.remove(at: indexPath.row)
                    self.tableView.reloadSections([1], with: .fade)
                }
                cell.dayPressHandler = nil
            } else {
                if selectedRepeatingDays.count == 0 {
                    cell.title = nil
                } else {
                    cell.title = LocalizedString("Add Another Day")
                    cell.btnDay.titleLabel?.textAlignment = .center
                    cell.btnDay.setTitleColor(UIColor.JGGCyan, for: .normal)
                    cell.btnClear.isHidden = true
                }
                cell.clearHandler = nil
                cell.dayPressHandler = {
                    self.showMonthlyPopup(isMonthly: self.selectedMonthly!)
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    private func showDatePopup(with dateButton: UIButton) {
        let datePopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGDatePickerPopupVC") as! JGGDatePickerPopupVC
        datePopupVC.themeColorType = .cyan
        datePopupVC.isAbleToMultipleSelect = false
        datePopupVC.doneButtonTitle = LocalizedString("Done")
        if let selectedDate = selectedDate {
            datePopupVC.selectedDates = [selectedDate]
        }
        datePopupVC.selectDateHandler = { (selectedDates) in
            if let selectedDate = selectedDates.first {
                self.selectedDate = selectedDate
                dateButton.setTitle(selectedDate.toString(format: .custom("MMM d")), for: .normal)
                dateButton.setTitleColor(UIColor.JGGBlack, for: .normal)
            }
        }
        showPopup(viewController: datePopupVC, transitionStyle: .slideFromBottom)
    }
    
    private func showTimePopup(with timeButton: UIButton) {
        let timePopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGAddTimeSlotsPopupVC") as! JGGAddTimeSlotsPopupVC
        timePopupVC.doneButtonTitle = LocalizedString("Done")
        timePopupVC.showEndTime = false
        timePopupVC.selectedStartTime = self.selectedStartTime
        timePopupVC.selectedEndTime = self.selectedEndTime
        timePopupVC.selectTimeHandler = { (startTime, endTime, count) in
            self.selectedStartTime = startTime
            self.selectedEndTime = endTime
            var timeString: String = ""
            if let startTime = startTime {
                timeString = startTime.timeForJacks()
            }
            if let endTime = endTime {
                timeString.append(" - ")
                timeString.append(endTime.timeForJacks())
            }
            timeButton.setTitle(timeString, for: .normal)
            timeButton.setTitleColor(UIColor.JGGBlack, for: .normal)
        }
        showPopup(viewController: timePopupVC, transitionStyle: .slideFromBottom)
    }
    
    private func showMonthlyPopup(isMonthly: Bool) {
        if isMonthly {
            let dayPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGMonthlySelectPickerVC") as! JGGMonthlySelectPickerVC
            dayPopupVC.selectedDates = selectedRepeatingDays
            dayPopupVC.selectedDatesHandler = { (selectedDays) in
                self.selectedRepeatingDays = selectedDays
                self.tableView.reloadData()
            }
            showPopup(viewController: dayPopupVC, transitionStyle: .slideFromBottom)
        } else {
            let dayPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGWeeklySelectPickerVC") as! JGGWeeklySelectPickerVC
            dayPopupVC.selectedDates = selectedRepeatingDays
            dayPopupVC.selectedDateHandler = { (selectedDays) in
                self.selectedRepeatingDays = selectedDays
                self.tableView.reloadData()
            }
            showPopup(viewController: dayPopupVC, transitionStyle: .slideFromBottom)
        }
    }
    
    private lazy var weekNames: [String] = [
        LocalizedString("Sunday"),
        LocalizedString("Monday"),
        LocalizedString("Tuesday"),
        LocalizedString("Wednesday"),
        LocalizedString("Thursday"),
        LocalizedString("Friday"),
        LocalizedString("Saturday")
    ]
    
    private lazy var dayNames: [String] = [
        "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th",
        "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th",
        "21th", "22th", "23th", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31th",
    ]
    
    private func dayName(for day: Int) -> String? {
        if let selectedMonthly = selectedMonthly {
            if selectedMonthly {
                if 0 < day && day <= dayNames.count {
                    return String(format: "Every %@ of the month", dayNames[day - 1])
                }
            } else {
                if 0 <= day && day < weekNames.count {
                    return String(format: "Every %@", weekNames[day])
                }
            }
        }
        return nil
    }
}

// MARK: - Cell classes -
class JGGPostJobTimeTypeCell: UITableViewCell {
    
    @IBOutlet weak var btnOnetimeJob: JGGYellowSelectingButton!
    @IBOutlet weak var btnRepeatingJob: JGGYellowSelectingButton!

    var selectingHandler: ((Int) -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        btnOnetimeJob.defaultColor = UIColor.JGGCyan
        btnRepeatingJob.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction fileprivate func onPressedButton(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        var index: Int = 0
        if sender.selected() {
            if sender == btnOnetimeJob {
                index = 1
                btnRepeatingJob.isHidden = true
                btnRepeatingJob.select(false)
            }
            else if sender == btnRepeatingJob {
                index = 2
                btnOnetimeJob.isHidden = true
                btnOnetimeJob.select(false)
            }
        } else {
            btnOnetimeJob.isHidden = false
            btnRepeatingJob.isHidden = false
        }
        selectingHandler(index)
    }
}

class JGGPostJobTimeOneTimeCell: UITableViewCell {
    
    @IBOutlet weak var btnSpecificDate: JGGYellowSelectingButton!
    @IBOutlet weak var btnAnyday: JGGYellowSelectingButton!
    @IBOutlet weak var viewOptionalDescription: UIView!
    @IBOutlet weak var lblOptionalDescription: UILabel!
    @IBOutlet weak var viewDateTimeContainer: UIView!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnTime: UIButton!

    var changedTypeHandler: (() -> Void)!
    var dateTapHandler: (() -> Void)!
    var timeTapHandler: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewOptionalDescription.isHidden = true
        self.viewDateTimeContainer.isHidden = true
        btnSpecificDate.defaultColor = UIColor.JGGCyan
        btnAnyday.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction private func onPressedType(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        if sender.selected() {
            if sender == btnSpecificDate {
                btnSpecificDate.isHidden = false
                btnAnyday.isHidden = true
                viewOptionalDescription.isHidden = true
                viewDateTimeContainer.isHidden = false
            } else if sender == btnAnyday {
                btnSpecificDate.isHidden = true
                btnAnyday.isHidden = false
                viewOptionalDescription.isHidden = false
                viewDateTimeContainer.isHidden = false
            }
        } else {
            btnSpecificDate.isHidden = false
            btnAnyday.isHidden = false
            viewOptionalDescription.isHidden = true
            viewDateTimeContainer.isHidden = true
        }
        changedTypeHandler()
    }
    
    @IBAction private func onPressedDate(_ sender: UIButton) {
        dateTapHandler()
    }
    
    @IBAction private func onPressedTime(_ sender: UIButton) {
        timeTapHandler()
    }
}

class JGGPostJobTimeRepeatingCell: UITableViewCell {
    
    @IBOutlet weak var btnWeekly: JGGYellowSelectingButton!
    @IBOutlet weak var btnMonthly: JGGYellowSelectingButton!

    var changedTypeHandler: ((Bool?) -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnWeekly.defaultColor = UIColor.JGGCyan
        btnMonthly.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction private func onPressedType(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        var isMonthly: Bool? = nil
        if sender.selected() {
            if sender == btnWeekly {
                isMonthly = false
                btnWeekly.isHidden = false
                btnMonthly.isHidden = true
            } else if sender == btnMonthly {
                isMonthly = true
                btnWeekly.isHidden = true
                btnMonthly.isHidden = false
            }
        } else {
            btnWeekly.isHidden = false
            btnMonthly.isHidden = false
        }
        changedTypeHandler(isMonthly)
    }
    
}

class JGGPostJobTimeRepeatingDayCell: UITableViewCell {
    
    @IBOutlet weak var btnDay: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    
    var title: String? {
        set {
            if let newValue = newValue {
                btnDay.setTitle(newValue, for: .normal)
                btnDay.setTitleColor(UIColor.JGGBlack, for: .normal)
                btnClear.isHidden = false
            } else {
                btnDay.setTitle(LocalizedString("Day"), for: .normal)
                btnDay.setTitleColor(UIColor.JGGGrey3, for: .normal)
                btnClear.isHidden = true
            }
            btnDay.titleLabel?.textAlignment = .left
        }
        get {
            return btnDay.title(for: .normal)
        }
    }
    var clearHandler: (() -> Void)?
    var dayPressHandler: (() -> Void)?
    
    @IBAction private func onPressedDay(_ sender: UIButton) {
        if let dayPressHandler = dayPressHandler {
            dayPressHandler()
        }
    }
    
    @IBAction private func onPressedClear(_ sender: UIButton) {
        if let clearHandler = clearHandler {
            clearHandler()
        }
    }
}
