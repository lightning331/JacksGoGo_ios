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

class JGGDatePickerPopupVC: JGGPopupBaseVC {

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
    var isAbleToMultipleSelect: Bool = false
    var doneButtonTitle: String?
    
    fileprivate var calendarView: JGGCalendarView!
    fileprivate var _themColor: UIColor = UIColor.JGGGreen
    fileprivate var _themColorType: JGGColorSchema = .green
    
    fileprivate var selectedDate: Date?
    
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

extension JGGDatePickerPopupVC: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    
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
        if let selectedDate = selectedDate,
            date.compare(.isSameDay(as: selectedDate)) {
            cell.viewCirlceBorder.isHidden = false
        } else {
            cell.viewCirlceBorder.isHidden = true
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if let selectedDate = selectedDate {
            calendar.deselect(dates: [selectedDate])
        }
        if let cell = cell as? JGGCalendarDayCell {
            cell.viewCirlceBorder.isHidden = false
        }
        selectedDate = date

        if cellState.dateBelongsTo == .previousMonthWithinBoundary {
            calendarView.moveMonth(to: -1)
        } else if cellState.dateBelongsTo == .followingMonthWithinBoundary {
            calendarView.moveMonth(to: 1)
        }
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if let cell = cell as? JGGCalendarDayCell {
            cell.viewCirlceBorder.isHidden = true
        }
    }
    
    func calendarDidScroll(_ calendar: JTAppleCalendarView) {
        print(#function)
    }
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        print(#function)
    }
    
}
