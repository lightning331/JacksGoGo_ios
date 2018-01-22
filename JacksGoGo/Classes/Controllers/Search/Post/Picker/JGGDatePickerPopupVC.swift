//
//  JGGDatePickerPopupVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit
import JTAppleCalendar
import MZFormSheetPresentationController
import AFDateHelper

class JGGDatePickerPopupVC: JGGPopupBaseVC, JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {

    @IBOutlet weak var viewCalendarContainer: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDuplicate: UIButton!
    
    var themeColorType: JGGColorSchema {
        set {
            _themColorType = newValue
            switch newValue {
            case .green:
                _themColor = UIColor.JGGGreen
                break
            case .cyan:
                _themColor = UIColor.JGGCyan
                break
            case .red:
                _themColor = UIColor.JGGRed
                break
            case .orange:
                _themColor = UIColor.JGGOrange
                break
            case .purple:
                _themColor = UIColor.JGGPurple
                break
            }
        }
        get {
            return _themColorType
        }
    }
    var selectedDates: [Date] = []
    var isAbleToMultipleSelect: Bool = false
    var doneButtonTitle: String?
    var selectDateHandler: (([Date]) -> Void)?
    var isDuplicateMode: Bool = false
    
    internal var calendarView: JGGCalendarView!
    internal var _themColor: UIColor = UIColor.JGGGreen
    internal var _themColorType: JGGColorSchema = .green
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let calendarView = UINib(nibName: "JGGCalendarView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! JGGCalendarView
        viewCalendarContainer.addSubview(calendarView)
        calendarView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalToSuperview()
        }
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.themeColorType = themeColorType
        calendarView.showMonthName(for: Date())
        self.calendarView = calendarView

        if let doneButtonTitle = doneButtonTitle {
            btnDuplicate.setTitle(doneButtonTitle, for: .normal)
        }
    }

    override func contentViewFrame(for presentationController: MZFormSheetPresentationController!, currentFrame: CGRect) -> CGRect {
        var frame = UIScreen.main.bounds.insetBy(dx: 10, dy: 50)
        frame.size.height = 450
        return frame
    }

    @IBAction func onPressedCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressedDuplicate(_ sender: UIButton) {
        if let selectDateHandler = selectDateHandler {
            selectDateHandler(selectedDates)
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

//}
//
//extension JGGDatePickerPopupVC: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    
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
        cell.color = _themColor
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
        for selectedDate in selectedDates {
            if date.compare(.isSameDay(as: selectedDate)) {
                cell.viewCirlceBorder.isHidden = false
            }
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        if isAbleToMultipleSelect {
            
        } else {
            
            if let selectedDate = selectedDates.first {
                calendar.deselect(dates: [selectedDate])
            }
            if let cell = cell as? JGGCalendarDayCell {
                cell.viewCirlceBorder.isHidden = false
            }
            selectedDates.removeAll()
            selectedDates.append(date)
            
            if cellState.dateBelongsTo == .previousMonthWithinBoundary {
                calendarView.moveMonth(to: -1)
                calendarView.calendarView.reloadData()
            } else if cellState.dateBelongsTo == .followingMonthWithinBoundary {
                calendarView.moveMonth(to: 1)
                calendarView.calendarView.reloadData()
            }
            calendar.reloadData()
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if !isAbleToMultipleSelect {
            if let cell = cell as? JGGCalendarDayCell {
                cell.viewCirlceBorder.isHidden = true
            }
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        if let currentMonth = visibleDates.monthDates.first?.date {
            calendarView.showMonthName(for: currentMonth)
        }
    }
    
    
}
