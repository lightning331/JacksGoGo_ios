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

import MZFormSheetPresentationController

class JGGPostServiceTimeSlotsDetailVC: JGGPostAppointmentBaseTableVC {

    var calendarView: JGGCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initTableView()
    }

    private func initTableView() {
        let headerView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: UIScreen.main.bounds.width, height: 350)))
        headerView.backgroundColor = UIColor.JGGGrey5
        let calendarView = UINib(nibName: "JGGCalendarView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! JGGCalendarView
        headerView.addSubview(calendarView)
        calendarView.snp.makeConstraints { (maker) in
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(16)
            maker.bottom.equalToSuperview().offset(-8)
        }
        calendarView.dataSource = self
        calendarView.delegate = self
        self.calendarView = calendarView
        self.tableView.tableHeaderView = headerView

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
        return 1 + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTimeSlotsEditCell") as! JGGTimeSlotsEditCell
            cell.editTimeHandler = { timeSlotCell in
                self.showAddTimeSlotsPopup()
            }
            cell.deleteTimeHandler = { timeSlotCell in
                self.deleteTimeSlots()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServiceTimeSlotsAddButtonCell") as! JGGPostServiceTimeSlotsAddButtonCell
            cell.addTimeSlotsHandler = {
                self.showAddTimeSlotsPopup()
            }
            cell.duplicateTimeSlotsHandler = {
                self.showCalendarPopup()
            }
            return cell
        }
    }
    
    // MARK: - Show Popup
    
    fileprivate func deleteTimeSlots() {
        JGGAlertViewController.show(title: LocalizedString("Remove Time Slots?"), message: LocalizedString("Would you remove a time slots?"), colorSchema: .red, okButtonTitle: LocalizedString("Remove"), okAction: {
            
        }, cancelButtonTitle: LocalizedString("Cancel"), cancelAction: nil)
    }
    
    fileprivate func showAddTimeSlotsPopup() {
        let timeSlotsPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGAddTimeSlotsPopupVC") as! JGGAddTimeSlotsPopupVC
        showPopup(viewController: timeSlotsPopupVC, transitionStyle: .bounce)
    }
    
    fileprivate func showCalendarPopup() {
        let timeSlotsPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGDatePickerPopupVC") as! JGGDatePickerPopupVC
        showPopup(viewController: timeSlotsPopupVC, transitionStyle: .bounce)
    }
    
}

extension JGGPostServiceTimeSlotsDetailVC: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let startDate = Date(timeIntervalSince1970: 47 * 365 * 24 * 3600)
        let endDate = Date(timeInterval: 10 * 365 * 24 * 3600, since: startDate)
        let configure = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 5)
        return configure
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "JGGCalendarDayCell", for: indexPath) as! JGGCalendarDayCell
        cell.lblDay.text = cellState.text
        if cellState.dateBelongsTo == .thisMonth {
            cell.alpha = 1.0
        } else {
            cell.alpha = 0.4
        }
        return cell
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
