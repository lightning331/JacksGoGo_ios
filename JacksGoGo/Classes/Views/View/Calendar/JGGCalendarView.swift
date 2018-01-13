//
//  JGGCalendarView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/21/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import JTAppleCalendar

class JGGCalendarView: UIView {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnForward: UIButton!
    @IBOutlet weak var lblMonthName: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    
    var dataSource: JTAppleCalendarViewDataSource? {
        set {
            self.calendarView.calendarDataSource = newValue
        }
        get {
            return self.calendarView.calendarDataSource
        }
    }
    var delegate: JTAppleCalendarViewDelegate? {
        set {
            self.calendarView.calendarDelegate = newValue
        }
        get {
            return self.calendarView.calendarDelegate
        }
    }
    
    private var dateFormatter: DateFormatter {
        let _df = DateFormatter()
        _df.dateFormat = "MMMM yyyy"
        return _df
    }
    
    var themeColorType: JGGColorSchema {
        set {
            _themColorType = newValue
            var backName = "button_previous_green"
            var nextName = "button_next_green"
            switch newValue {
            case .green:
                backName = "button_previous_green"
                nextName = "button_next_green"
                break
            case .cyan:
                backName = "button_previous_cyan"
                nextName = "button_next_cyan"
                break
            case .orange:
                backName = "button_previous_orange"
                nextName = "button_next_orange"
                break
            case .purple:
                backName = "button_previous_purple"
                nextName = "button_next_purple"
                break
            default:
                backName = "button_previous_green"
                nextName = "button_next_green"
                break
            }
            btnBack.setImage(UIImage(named: backName), for: .normal)
            btnForward.setImage(UIImage(named: nextName), for: .normal)
        }
        get {
            return _themColorType
        }
    }
    
    fileprivate var _themColorType: JGGColorSchema = .green
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.calendarView.register(UINib(nibName: "JGGCalendarDayCell", bundle: nil),
                                   forCellWithReuseIdentifier: "JGGCalendarDayCell")
    }

    @IBAction func onPressedPreviousMonth(_ sender: Any) {
        moveMonth(to: -1)
    }
    
    @IBAction func onPressedNextMonth(_ sender: Any) {
        moveMonth(to: 1)
    }
    
    func moveMonth(to arrow: Int) {
        let currentMonth = self.calendarView.visibleDates().monthDates.first!.date
        guard let targetMonth = Calendar.current.date(byAdding: .month, value: arrow, to: currentMonth) else { return }
        self.calendarView.scrollToDate(targetMonth)
        
//        showMonthName(for: targetMonth)
    }
    
    func showMonthName(for date: Date) -> Void {
        self.lblMonthName.text = dateFormatter.string(from: date)
    }
}
