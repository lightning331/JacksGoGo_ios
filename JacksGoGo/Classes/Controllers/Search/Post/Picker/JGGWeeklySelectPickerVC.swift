//
//  JGGWeeklySelectPickerVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import MZFormSheetPresentationController

class JGGWeeklySelectPickerVC: JGGPopupBaseVC, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblWeekDays: UITableView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    
    private lazy var weekdates: [String] = [
        LocalizedString("Sunday"),
        LocalizedString("Monday"),
        LocalizedString("Tuesday"),
        LocalizedString("Wednesday"),
        LocalizedString("Thursday"),
        LocalizedString("Friday"),
        LocalizedString("Saturday")
    ]
    
    var selectedDates: [Int] = []
    var selectedDateHandler: (([Int]) -> Void)?
    
    fileprivate lazy var days: [(Int, Bool)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (index, day) in weekdates.enumerated() {
            var selected = false
            for selectedDay in selectedDates {
                if index == selectedDay {
                    selected = true
                    break
                }
            }
            days.append((index, selected))
        }
        
        self.tblWeekDays.dataSource = self
        self.tblWeekDays.delegate = self
        
    }

    override func contentViewFrame(for presentationController: MZFormSheetPresentationController!, currentFrame: CGRect) -> CGRect {
        var frame = UIScreen.main.bounds.insetBy(dx: 10, dy: 50)
        frame.size.height = 450
        return frame
    }

    @IBAction func onPressedCancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressedDone(_ sender: UIButton) {
        if let selectedDateHandler = selectedDateHandler
        {
            selectedDates.removeAll()
            for (day, selected) in days {
                if selected {
                    selectedDates.append(day)
                }
            }
            selectedDateHandler(selectedDates)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITableView datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekdates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGWeekDateCell") as! JGGWeekDateCell
        cell.title = weekdates[days[indexPath.row].0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.JGGWhite
        }
        days[indexPath.row].1 = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        days[indexPath.row].1 = false
    }
    
}

class JGGWeekDateCell: UITableViewCell {
    
    @IBOutlet weak var btnWeekDate: UIButton!
    
    var title: String? {
        set {
            btnWeekDate.setTitle(newValue, for: .normal)
        }
        get {
            return btnWeekDate.title(for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnWeekDate.isUserInteractionEnabled = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            btnWeekDate.backgroundColor = UIColor.JGGCyan
            btnWeekDate.setTitleColor(UIColor.JGGWhite, for: .normal)
        } else {
            btnWeekDate.backgroundColor = UIColor.clear
            btnWeekDate.setTitleColor(UIColor.JGGCyan, for: .normal)
        }
    }
    
}
