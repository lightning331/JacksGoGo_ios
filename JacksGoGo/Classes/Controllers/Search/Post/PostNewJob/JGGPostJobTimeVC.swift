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

    
    fileprivate var selectedJobType: Int = -1
    fileprivate var selectedDate: Date?
    fileprivate var selectedStartTime: Date?
    fileprivate var selectedEndTime: Date?
    fileprivate var isSpecifiedDate: Bool?
    fileprivate var selectedRepeatingType: JGGRepetitionType?
    fileprivate lazy var selectedRepeatingDays: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.isHidden = false
               
        if SHOW_TEMP_DATA {
            showTemporaryData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showOriginalInfo()
        
    }

    private func showTemporaryData() {
        selectedJobType = 0
        selectedRepeatingType = .weekly
        selectedRepeatingDays = [0, 5]
    }

    private func showOriginalInfo() {
        if let parent = self.parent as? JGGPostStepRootBaseVC,
            let editingJob = parent.editingJob
        {
            selectedJobType = editingJob.appointmentType
            selectedRepeatingType = editingJob.repetitionType
            selectedRepeatingDays =
                editingJob
                    .repetition?
                    .split(separator: ",")
                    .compactMap { Int($0) }
                ?? []
            let jobTime = editingJob.sessions?.first
            isSpecifiedDate = jobTime?.isSpecific
            selectedDate = jobTime?.startOn
            selectedStartTime = jobTime?.startOn
            selectedEndTime = jobTime?.endOn
        }
    }
    
    override func onPressedNext(_ sender: UIButton) {
        var readyToNext: Bool = true
        if selectedJobType == -1 {
            Toast(text: LocalizedString("Select a kind of job"), delay: 0, duration: 3).show()
            readyToNext = false
        } else {
            if selectedJobType == 1 { // One time job
                if selectedDate == nil || (selectedStartTime == nil && selectedEndTime == nil) {
                    Toast(text: LocalizedString("Please set date and time."), delay: 0, duration: 3).show()
                    readyToNext = false
                }
            } else { // Repeating job
                if selectedRepeatingType == .none || selectedRepeatingDays.count == 0 {
                    Toast(text: LocalizedString("Please set dates for repeating."), delay: 0, duration: 3).show()
                    readyToNext = false
                }
            }
        }
        if readyToNext {
            super.onPressedNext(sender)
        }
    }
    
    override func updateData(_ sender: Any) {
        self.view.endEditing(true)
        if let parentVC = parent as? JGGPostJobStepRootVC {
            var creatingJob: JGGJobModel?
            if parentVC.editingJob != nil {
                creatingJob = parentVC.editingJob
            } else {
                creatingJob = parentVC.creatingJob
            }
            if let creatingJob = creatingJob {
                creatingJob.appointmentType = selectedJobType
                if let selectedDate = selectedDate, let selectedStartTime = selectedStartTime, let isSpecific = isSpecifiedDate {
                    let dateString = selectedDate.toString(format: DateOnly)
                    let startTimeString = selectedStartTime.toString(format: TimeOnly)
                    let startFullTimeString = String(format: "%@T%@", dateString, startTimeString)
                    let startTime = Date(fromString: startFullTimeString, format: FullDate)
                    var endTime: Date? = nil
                    if let selectedEndTime = selectedEndTime {
                        let endTimeString = selectedEndTime.toString(format: TimeOnly)
                        let endFullTimeString = String(format: "%@T%@", dateString, endTimeString)
                        endTime = Date(fromString: endFullTimeString, format: FullDate)
                    }
                    creatingJob.sessions = [JGGTimeSlotModel(startOn: startTime, endOn: endTime, people: nil, isSpecific: isSpecific)]
                    
                }
                else if selectedRepeatingType != .none && selectedRepeatingDays.count > 0 {
                    creatingJob.repetitionType = selectedRepeatingType
                    creatingJob.repetition = selectedRepeatingDays.compactMap { String($0) }.joined(separator: ",")
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if selectedJobType != 1 && selectedJobType > -1 {
            return 2
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if selectedJobType == -1 {
                return 1
            }
            return 2
        } else {
            return selectedRepeatingDays.count + 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeTypeCell") as! JGGPostJobTimeTypeCell
                cell.selectingHandler = { index in
                    self.selectedJobType = index
                    self.tableView.reloadData()
                }
                cell.selectedJobType = self.selectedJobType
                return cell
            } else if indexPath.row == 1 {
                if selectedJobType == 1 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeOneTimeCell") as! JGGPostJobTimeOneTimeCell
                    cell.changedTypeHandler = { isSpecific in
                        self.tableView.beginUpdates()
                        self.tableView.endUpdates()
                        self.isSpecifiedDate = isSpecific
                    }
                    cell.dateTapHandler = {
                        self.showDatePopup(with: cell.btnDate)
                    }
                    cell.timeTapHandler =  {
                        self.showTimePopup(with: cell.btnTime)
                    }
                    cell.isSpecifyDate = isSpecifiedDate
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeRepeatingCell") as! JGGPostJobTimeRepeatingCell
                    cell.changedTypeHandler = { isMonthly in
                        self.selectedRepeatingType = isMonthly
                        self.selectedRepeatingDays.removeAll()
                        self.tableView.reloadData()
                    }
                    cell.repetitionType = selectedRepeatingType
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
                    self.showMonthlyPopup(repeatingType: self.selectedRepeatingType)
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
        timePopupVC.isHideCloseEndTimeButton = false
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
    
    private func showMonthlyPopup(repeatingType: JGGRepetitionType?) {
        if repeatingType == .monthly {
            let dayPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGMonthlySelectPickerVC") as! JGGMonthlySelectPickerVC
            dayPopupVC.selectedDates = selectedRepeatingDays
            dayPopupVC.selectedDatesHandler = { (selectedDays) in
                self.selectedRepeatingDays = selectedDays
                self.tableView.reloadData()
            }
            showPopup(viewController: dayPopupVC, transitionStyle: .slideFromBottom)
        } else if repeatingType == .weekly {
            let dayPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGWeeklySelectPickerVC") as! JGGWeeklySelectPickerVC
            dayPopupVC.selectedDates = selectedRepeatingDays
            dayPopupVC.selectedDateHandler = { (selectedDays) in
                self.selectedRepeatingDays = selectedDays
                self.tableView.reloadData()
            }
            showPopup(viewController: dayPopupVC, transitionStyle: .slideFromBottom)
        }
    }
    
    private func dayName(for day: Int) -> String? {
        if selectedRepeatingType == .monthly {
            if 0 < day && day <= dayNames.count {
                return String(format: "Every %@ of the month", dayNames[day - 1])
            }
        } else if selectedRepeatingType == .weekly {
            if 0 <= day && day < weekNames.count {
                return String(format: "Every %@", weekNames[day])
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
    var selectedJobType: Int = -1 {
        didSet {
            switch selectedJobType {
            case -1:
                btnOnetimeJob.isHidden = false
                btnRepeatingJob.isHidden = false
                btnOnetimeJob.select(false)
                btnRepeatingJob.select(false)
                break
            case 1:
                btnOnetimeJob.isHidden = false
                btnRepeatingJob.isHidden = true
                btnOnetimeJob.select(true)
                break
            default:
                btnOnetimeJob.isHidden = true
                btnRepeatingJob.isHidden = false
                btnRepeatingJob.select(true)
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnOnetimeJob.defaultColor = UIColor.JGGCyan
        btnRepeatingJob.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction fileprivate func onPressedButton(_ sender: JGGYellowSelectingButton) {
        var type: Int = -1
        if !sender.selected() {
            if sender == btnOnetimeJob {
                type = 1
            }
            else if sender == btnRepeatingJob {
                type = 0
            }
        }
        self.selectedJobType = type
        selectingHandler(type)
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

    var changedTypeHandler: ((Bool?) -> Void)!
    var dateTapHandler: (() -> Void)!
    var timeTapHandler: (() -> Void)!
    var isSpecifyDate: Bool? {
        didSet {
            if let isSpecitied = isSpecifyDate {
                if isSpecitied {
                    btnSpecificDate.isHidden = false
                    btnAnyday.isHidden = true
                    viewOptionalDescription.isHidden = true
                    viewDateTimeContainer.isHidden = false
                    btnSpecificDate.select(true)
                    btnAnyday.select(false)
                } else {
                    btnSpecificDate.isHidden = true
                    btnAnyday.isHidden = false
                    viewOptionalDescription.isHidden = false
                    viewDateTimeContainer.isHidden = false
                    btnSpecificDate.select(false)
                    btnAnyday.select(true)
                }
            } else {
                btnSpecificDate.isHidden = false
                btnAnyday.isHidden = false
                viewOptionalDescription.isHidden = true
                viewDateTimeContainer.isHidden = true
                btnSpecificDate.select(false)
                btnAnyday.select(false)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewOptionalDescription.isHidden = true
        self.viewDateTimeContainer.isHidden = true
        btnSpecificDate.defaultColor = UIColor.JGGCyan
        btnAnyday.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction private func onPressedType(_ sender: JGGYellowSelectingButton) {
        var isSpecific: Bool? = nil
        if !sender.selected() {
            if sender == btnSpecificDate {
                isSpecific = true
            } else if sender == btnAnyday {
                isSpecific = false
            }
        }
        self.isSpecifyDate = isSpecific
        changedTypeHandler(isSpecific)
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

    var changedTypeHandler: ((JGGRepetitionType?) -> Void)!
    var repetitionType: JGGRepetitionType? {
        didSet {
            if let repetitionType = repetitionType {
                if repetitionType == .weekly {
                    btnWeekly.isHidden = false
                    btnMonthly.isHidden = true
                    btnWeekly.select(true)
                    btnMonthly.select(false)
                } else if repetitionType == .monthly {
                    btnWeekly.isHidden = true
                    btnMonthly.isHidden = false
                    btnWeekly.select(false)
                    btnMonthly.select(true)
                }
            } else {
                btnWeekly.isHidden = false
                btnMonthly.isHidden = false
                btnWeekly.select(false)
                btnMonthly.select(false)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnWeekly.defaultColor = UIColor.JGGCyan
        btnMonthly.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction private func onPressedType(_ sender: JGGYellowSelectingButton) {
        var repetitionType: JGGRepetitionType? = nil
        if !sender.selected() {
            if sender == btnWeekly {
                repetitionType = .weekly
            } else if sender == btnMonthly {
                repetitionType = .monthly
            }
        }
        self.repetitionType = repetitionType
        changedTypeHandler(repetitionType)
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
