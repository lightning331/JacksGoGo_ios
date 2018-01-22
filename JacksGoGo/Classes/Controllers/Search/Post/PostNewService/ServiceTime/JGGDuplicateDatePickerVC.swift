//
//  JGGDuplicateDatePickerVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/22/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import JTAppleCalendar

class JGGDuplicateDatePickerVC: JGGDatePickerPopupVC {

    var sourceDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
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
        if date.compare(.isSameDay(as: sourceDate)) {
            cell.lblDay.textColor = _themColor
        } else {
            cell.lblDay.textColor = UIColor.JGGBlack
        }
        cell.viewCirlceBorder.isHidden = true
        for selectedDate in selectedDates {
            if date.compare(.isSameDay(as: selectedDate)) {
                cell.viewCirlceBorder.isHidden = false
            }
        }
        return cell
    }

    override func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        if date.compare(.isSameDay(as: sourceDate)) {
            calendar.deselect(dates: [date])
            return
        }
        
        var isSelect: Bool = true
        var index: Int = 0
        for aDate in selectedDates {
            if aDate.compare(.isSameDay(as: date)) {
                isSelect = false
                selectedDates.remove(at: index)
                break
            }
            index += 1
        }
        if isSelect {
            selectedDates.append(date)
        }
        
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
    
    
}
