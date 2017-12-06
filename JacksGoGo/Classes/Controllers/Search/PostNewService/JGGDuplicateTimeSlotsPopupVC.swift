//
//  JGGDuplicateTimeSlotsPopupVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit
import JTAppleCalendar
import MZFormSheetPresentationController

class JGGDuplicateTimeSlotsPopupVC: JGGPopupBaseVC {

    @IBOutlet weak var viewCalendarContainer: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDuplicate: UIButton!
    
    var calendarView: JGGCalendarView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let calendarView = UINib(nibName: "JGGCalendarView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! JGGCalendarView
        viewCalendarContainer.addSubview(calendarView)
        calendarView.snp.makeConstraints { (maker) in
            maker.left.right.top.bottom.equalToSuperview()
        }
        calendarView.dataSource = self
        calendarView.delegate = self
        self.calendarView = calendarView

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

extension JGGDuplicateTimeSlotsPopupVC: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    
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
