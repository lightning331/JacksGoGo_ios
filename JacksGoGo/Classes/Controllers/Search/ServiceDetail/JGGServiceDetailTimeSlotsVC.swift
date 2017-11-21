//
//  JGGServiceDetailTimeSlotsVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/21/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit
import JTAppleCalendar

class JGGServiceDetailTimeSlotsVC: JGGSearchBaseVC {

    @IBOutlet weak var btnToday: UIBarButtonItem!
    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var calendarView: JGGCalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        
        self.tableView.register(UINib(nibName: "JGGTimeSlotCell", bundle: nil),
                                forCellReuseIdentifier: "JGGTimeSlotCell")
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false

    }

    
}

extension JGGServiceDetailTimeSlotsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.frame.width, height: 40)))
        titleView.backgroundColor = UIColor.JGGWhite
        let sectionLabel = UILabel(frame: titleView.bounds)
        sectionLabel.textAlignment = .center
        sectionLabel.font = UIFont.JGGListTitle
        sectionLabel.text = LocalizedString("Time Slots")
        titleView.addSubview(sectionLabel)
        return titleView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTimeSlotCell") as! JGGTimeSlotCell
        
        return cell
    }
    
}

extension JGGServiceDetailTimeSlotsVC: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    
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
