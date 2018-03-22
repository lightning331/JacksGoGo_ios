//
//  JGGPostServiceTimeSlotsDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit
import JTAppleCalendar
import Toaster

import MZFormSheetPresentationController

class JGGPostServiceTimeSlotsDetailVC: JGGPostServiceTimeSlotsBaseVC {

    var calendarView: JGGCalendarView!

    fileprivate lazy var filteredDates: [String: [JGGTimeSlotModel]] = [:]
    fileprivate var selectedDate: Date = Date(fromString: Date().toString(format: DateOnly),
                                              format: DateOnly)!
    fileprivate var selectedDates: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        filterDateOfTimeSlots()
        
        self.initTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showToday(_:)),
            name: NSNotification.Name(rawValue: JGGNotificationShowToday),
            object: nil
        )
        (self.navigationController?.parent?.parent?.parent as? JGGPostServiceRootVC)?.addTodayButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name(rawValue: JGGNotificationShowToday),
            object: nil
        )
        (self.navigationController?.parent?.parent?.parent as? JGGPostServiceRootVC)?.removeTodayButton()
    }
    
    private func initTableView() {
        let headerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 350)))
        headerView.backgroundColor = UIColor.JGGGrey5
        let calendarView =
            UINib(nibName: "JGGCalendarView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)[0] as! JGGCalendarView
        headerView.addSubview(calendarView)
        calendarView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(16)
            maker.bottom.equalToSuperview().offset(-8)
        }
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.showMonthName(for: Date())
        self.calendarView = calendarView
        self.tableView.tableHeaderView = headerView

    }
    
    override func updateData(_ sender: Any) {
        self.view.endEditing(true)
        if let parentVC = self.navController.parent as? JGGPostServiceStepRootVC {
            if self.navController.selectedPeopleType == .onePerson {
                self.navController.onePersonTimeSlots = filteredDates.flatMap { $1 }
                parentVC.creatingJob?.sessions = self.navController.onePersonTimeSlots
            } else if self.navController.selectedPeopleType == .multiplePeople {
                self.navController.multiplePeopleTimeSlots = filteredDates.flatMap { $1 }
                parentVC.creatingJob?.sessions = self.navController.multiplePeopleTimeSlots
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "gotoTimeSlotsFinalVC" {
                updateData(self)
            }
        }
    }
    
    @objc func showToday(_ sender: Notification) -> Void {
        self.calendarView.calendarView.scrollToDate(Date())
    }
    
    fileprivate var arrayTimeSlots : [JGGTimeSlotModel] {
        get {
            if self.navController.selectedPeopleType == .onePerson {
                return self.navController.onePersonTimeSlots
            } else if self.navController.selectedPeopleType == .multiplePeople {
                return self.navController.multiplePeopleTimeSlots
            } else {
                return []
            }
        }
        /* set {
            if self.navController.selectedPeopleType == .onePerson {
                self.navController.onePersonTimeSlots = newValue
            } else if self.navController.selectedPeopleType == .multiplePeople {
                self.navController.multiplePeopleTimeSlots = newValue
            } else {
                
            }
        } */
    }
    
    fileprivate func filterDateOfTimeSlots() {
        filteredDates.removeAll()
        for timeSlot in arrayTimeSlots {
            if let startTime = timeSlot.startOn {
                let dateString = startTime.toString(format: DateOnly)
                var slots = filteredDates[dateString]
                if slots == nil {
                    slots = Array()
                    filteredDates[dateString] = slots!
                }
                slots!.append(timeSlot)
                filteredDates[dateString] = slots!
            }
        }
        filterSelectedDates()
    }
    
    fileprivate func filterSelectedDates() {
        selectedDates =
            filteredDates
                .keys
                .flatMap { Date(fromString: $0, format: DateOnly) }

    }
    
    fileprivate var selectedDateTimeSlots: [JGGTimeSlotModel] {
        let dateString = selectedDate.toString(format: DateOnly)
        return filteredDates[dateString] ?? []
    }
    
    fileprivate func addTimeSlot(_ timeSlot: JGGTimeSlotModel) {
        if let startTime = timeSlot.startOn {
            let dateString = startTime.toString(format: DateOnly)
            var slots = filteredDates[dateString]
            if slots == nil {
                slots = []
                filteredDates[dateString] = slots!
            }
            slots!.append(timeSlot)
            filteredDates[dateString] = slots!
            filterSelectedDates()
            self.calendarView.calendarView.reloadData()
        }
    }
    
    fileprivate func removeTimeSlot(_ timeSlot: JGGTimeSlotModel) {
        if let startTime = timeSlot.startOn {
            let dateString = startTime.toString(format: DateOnly)
            if let index = filteredDates[dateString]?.index(of: timeSlot) {
                filteredDates[dateString]?.remove(at: index)
                if filteredDates[dateString]!.count == 0 {
                    filteredDates.removeValue(forKey: dateString)
                    filterSelectedDates()
                    self.calendarView.calendarView.reloadData()
                }
            }
        }
    }

    fileprivate func duplicateTimeSlots(to dates: [Date]) {
        for date in dates {
            let difDays = Int(date.since(selectedDate, in: .day))
            let dupTimeSlots = selectedDateTimeSlots.map({ (slot) -> JGGTimeSlotModel in
                let dupSlot = JGGTimeSlotModel()
                dupSlot.startOn = slot.startOn?.adjust(.day, offset: difDays)
                dupSlot.endOn = slot.endOn?.adjust(.day, offset: difDays)
                dupSlot.peoples = slot.peoples
                return dupSlot
            })
            let dateString = date.toString(format: DateOnly)
            filteredDates[dateString] = dupTimeSlots
            filterSelectedDates()
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "JGGPostServiceTimeSlotsTitleEditCell") as! JGGPostServiceTimeSlotsTitleEditCell
        headerView.viewEditTitle.isHidden = true
        headerView.viewFixedTitle.isHidden = false
        return headerView.contentView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateTimeSlots.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < selectedDateTimeSlots.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTimeSlotsEditCell") as! JGGTimeSlotsEditCell
            cell.timeSlots = selectedDateTimeSlots[indexPath.row]
            cell.editTimeHandler = { timeSlotCell in
                self.showTimeSlotsPopup(with: timeSlotCell.timeSlots)
            }
            cell.deleteTimeHandler = { timeSlotCell in
                self.removeTimeSlot(timeSlotCell.timeSlots)
                self.tableView.reloadSections([0], with: .automatic)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServiceTimeSlotsAddButtonCell") as! JGGPostServiceTimeSlotsAddButtonCell
            cell.addTimeSlotsHandler = {
                self.showTimeSlotsPopup()
            }
            cell.duplicateTimeSlotsHandler = {
                self.showCalendarPopup()
            }
            return cell
        }
    }
    
    // MARK: - Show Popup
    
    fileprivate func deleteTimeSlots() {
        JGGAlertViewController.show(title: LocalizedString("Remove Time Slots?"), message: LocalizedString("Would you remove a time slots?"), colorSchema: .red, okButtonTitle: LocalizedString("Remove"), okAction: { text in
            
        }, cancelButtonTitle: LocalizedString("Cancel"), cancelAction: nil)
    }
    
    fileprivate func showTimeSlotsPopup(with timeSlot: JGGTimeSlotModel? = nil) {
        let timeSlotsPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGAddTimeSlotsPopupVC") as! JGGAddTimeSlotsPopupVC
        timeSlotsPopupVC.selectTimeHandler = { (startTime, endTime, number) in
            if let startTime = startTime, let endTime = endTime {
                let startTimeString = self.selectedDate.toString(format: DateOnly) + "T" + startTime.toString(format: TimeOnly)
                let endTimeString = self.selectedDate.toString(format: DateOnly) + "T" + endTime.toString(format: TimeOnly)
                let startOnTime = Date(fromString: startTimeString, format: FullDate)
                let endOnTime = Date(fromString: endTimeString, format: FullDate)
                
                if timeSlot == nil {
                    let newSlot = JGGTimeSlotModel()
                    newSlot.startOn = startOnTime
                    newSlot.endOn = endOnTime
                    newSlot.peoples = number
                    self.addTimeSlot(newSlot)
                } else {
                    timeSlot!.startOn = startOnTime
                    timeSlot!.endOn = endOnTime
                    timeSlot!.peoples = number
                }
                self.tableView.reloadSections([0], with: .automatic)
            }
        }
        if let timeSlot = timeSlot {
            timeSlotsPopupVC.doneButtonTitle = LocalizedString("Save")
            timeSlotsPopupVC.selectedStartTime = timeSlot.startOn
            timeSlotsPopupVC.selectedEndTime = timeSlot.endOn
        } else {
            timeSlotsPopupVC.doneButtonTitle = LocalizedString("Add")
        }
        if self.navController.selectedPeopleType == .multiplePeople {
            timeSlotsPopupVC.isHideNumberOfPax = false
        }
        showPopup(viewController: timeSlotsPopupVC, transitionStyle: .bounce)
    }
    
    fileprivate func showCalendarPopup(with date: Date? = nil) {
        if selectedDateTimeSlots.count > 0 {
            let datePickerVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGDuplicateDatePickerVC") as! JGGDuplicateDatePickerVC
            datePickerVC.sourceDate = selectedDate
            datePickerVC.selectDateHandler = { selectedDates in
                self.duplicateTimeSlots(to: selectedDates)
                self.calendarView.calendarView.reloadDates(selectedDates)
            }
            showPopup(viewController: datePickerVC, transitionStyle: .bounce)
        } else {
            Toast(text: LocalizedString("No time slots to duplicate."), delay: 0, duration: 0.3).show()
        }
    }
    
}

extension JGGPostServiceTimeSlotsDetailVC: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = Date()
        let endDate = Date(timeInterval: 365 * 24 * 3600, since: startDate)
        let configure = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 5)
        return configure
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "JGGCalendarDayCell", for: indexPath) as! JGGCalendarDayCell
        cell.lblDay.text = cellState.text
        cell.color = UIColor.JGGGreen
        if date.compare(.isEarlier(than: Date().dateFor(.yesterday))) || cellState.dateBelongsTo != .thisMonth {
            cell.alpha = 0.4
            cell.viewGreenDot.isHidden = true
        } else if date.compare(.isToday) {
            cell.alpha = 1.0
            cell.viewGreenDot.isHidden = false
        } else {
            cell.alpha = 1.0
            cell.viewGreenDot.isHidden = true
        }
        cell.viewCirlceBorder.isHidden = true
        cell.lblDay.textColor = UIColor.JGGBlack
        if date.compare(.isSameDay(as: selectedDate)) {
            cell.viewCirlceBorder.isHidden = false
        }
        for aDate in selectedDates {
            if date.compare(.isSameDay(as: aDate)) {
                cell.lblDay.textColor = UIColor.JGGGreen
            }
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        selectedDate = date
        self.tableView.reloadSections([0], with: .automatic)
        
        if let cell = cell as? JGGCalendarDayCell {
            cell.viewCirlceBorder.isHidden = false
        }
        
        if cellState.dateBelongsTo == .previousMonthWithinBoundary {
            calendarView.moveMonth(to: -1)
            calendarView.calendarView.reloadData()
        } else if cellState.dateBelongsTo == .followingMonthWithinBoundary {
            calendarView.moveMonth(to: 1)
            calendarView.calendarView.reloadData()
        }
        calendar.reloadData()

    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        if let currentMonth = visibleDates.monthDates.first?.date {
            calendarView.showMonthName(for: currentMonth)
        }
    }
}

class JGGPostServiceTimeSlotsTitleEditCell: UITableViewCell {
    
    @IBOutlet weak var viewFixedTitle: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var viewEditTitle: UIView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var btnDone: UIButton!
    
    var changedTitleHandler: ((String?) -> Void)!
    
    @IBAction fileprivate func onPressedEdit(_ sender: UIButton) {
        viewFixedTitle.isHidden = true
        viewEditTitle.isHidden = false
        txtTitle.text = lblTitle.text
    }
    
    @IBAction fileprivate func onPressedDone(_ sender: UIButton) {
        viewFixedTitle.isHidden = false
        viewEditTitle.isHidden = true
        lblTitle.text = txtTitle.text

    }
}

class JGGPostServiceTimeSlotsAddButtonCell: UITableViewCell {
    
    @IBOutlet weak var btnAddTimeSlots: UIButton!
    @IBOutlet weak var btnDuplicateSlots: UIButton!
    
    var addTimeSlotsHandler: (() -> Void)!
    var duplicateTimeSlotsHandler: (() -> Void)!
    
    @IBAction fileprivate func onPressedAddTimeSlots(_ sender: UIButton) {
        addTimeSlotsHandler()
    }
    
    @IBAction fileprivate func onPressedDuplicateTimeSlots(_ sender: UIButton) {
        duplicateTimeSlotsHandler()
    }
    
    
}
