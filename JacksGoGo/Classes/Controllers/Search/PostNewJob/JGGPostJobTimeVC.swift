//
//  JGGPostJobTimeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Toaster

class JGGPostJobTimeVC: JGGPostAppointmentBaseTableVC {

    
    fileprivate var selectedTimeType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnNext.isHidden = false
    }
    
    override func onPressedNext(_ sender: UIButton) {
        if selectedTimeType == 0 {
            Toast(text: LocalizedString("Select one"), delay: 0, duration: 3).show()
        } else {
            super.onPressedNext(sender)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedTimeType > 0 {
            return 2
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeTypeCell") as! JGGPostJobTimeTypeCell
            cell.selectingHandler = { index in
                self.selectedTimeType = index
                self.tableView.reloadData()
            }
            return cell
        } else if indexPath.row == 1 {
            if selectedTimeType == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeOneTimeCell") as! JGGPostJobTimeOneTimeCell
                cell.changedTypeHandler = {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
                cell.dateTapHandler = {
                    self.showDatePopup()
                }
                cell.timeTapHandler =  {
                    
                }
                return cell
            } else if selectedTimeType == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostJobTimeRepeating") as! JGGPostJobTimeRepeating
                cell.changedTypeHandler = {
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
                cell.dayTapHandler = {
                    self.showDatePopup()
                }
                cell.clearDaysHandler = {
                    
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    private func showDatePopup() {
        let datePopupVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGDatePickerPopupVC") as! JGGDatePickerPopupVC
        datePopupVC.themeColorType = .cyan
        datePopupVC.isAbleToMultipleSelect = false
        datePopupVC.doneButtonTitle = LocalizedString("Done")
        showPopup(viewController: datePopupVC, transitionStyle: .slideFromBottom)
        
    }
}

// MARK: - Cell classes -
class JGGPostJobTimeTypeCell: UITableViewCell {
    
    @IBOutlet weak var btnOnetimeJob: JGGYellowSelectingButton!
    @IBOutlet weak var btnRepeatingJob: JGGYellowSelectingButton!

    var selectingHandler: ((Int) -> Void)!

    override func awakeFromNib() {
        super.awakeFromNib()
        btnOnetimeJob.defaultColor = UIColor.JGGCyan
        btnRepeatingJob.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction fileprivate func onPressedButton(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        var index: Int = 0
        if sender.selected() {
            if sender == btnOnetimeJob {
                index = 1
                btnRepeatingJob.isHidden = true
                btnRepeatingJob.select(false)
            }
            else if sender == btnRepeatingJob {
                index = 2
                btnOnetimeJob.isHidden = true
                btnOnetimeJob.select(false)
            }
        } else {
            btnOnetimeJob.isHidden = false
            btnRepeatingJob.isHidden = false
        }
        selectingHandler(index)
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

    var changedTypeHandler: (() -> Void)!
    var dateTapHandler: (() -> Void)!
    var timeTapHandler: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewOptionalDescription.isHidden = true
        self.viewDateTimeContainer.isHidden = true
        btnSpecificDate.defaultColor = UIColor.JGGCyan
        btnAnyday.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction private func onPressedType(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        if sender.selected() {
            if sender == btnSpecificDate {
                btnSpecificDate.isHidden = false
                btnAnyday.isHidden = true
                viewOptionalDescription.isHidden = true
                viewDateTimeContainer.isHidden = false
            } else if sender == btnAnyday {
                btnSpecificDate.isHidden = true
                btnAnyday.isHidden = false
                viewOptionalDescription.isHidden = false
                viewDateTimeContainer.isHidden = false
            }
        } else {
            btnSpecificDate.isHidden = false
            btnAnyday.isHidden = false
            viewOptionalDescription.isHidden = true
            viewDateTimeContainer.isHidden = true
        }
        changedTypeHandler()
    }
    
    @IBAction private func onPressedDate(_ sender: UIButton) {
        dateTapHandler()
    }
    
    @IBAction private func onPressedTime(_ sender: UIButton) {
        timeTapHandler()
    }
}

class JGGPostJobTimeRepeating: UITableViewCell {
    
    @IBOutlet weak var btnWeekly: JGGYellowSelectingButton!
    @IBOutlet weak var btnMonthly: JGGYellowSelectingButton!
    @IBOutlet weak var viewDayContainer: UIView!
    @IBOutlet weak var btnDays: UIButton!
    @IBOutlet weak var btnClearDays: UIButton!

    var changedTypeHandler: (() -> Void)!
    var dayTapHandler: (() -> Void)!
    var clearDaysHandler: (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewDayContainer.isHidden = true
        btnWeekly.defaultColor = UIColor.JGGCyan
        btnMonthly.defaultColor = UIColor.JGGCyan
    }
    
    @IBAction private func onPressedType(_ sender: JGGYellowSelectingButton) {
        sender.select(!sender.selected())
        if sender.selected() {
            if sender == btnWeekly {
                btnWeekly.isHidden = false
                btnMonthly.isHidden = true
            } else if sender == btnMonthly {
                btnWeekly.isHidden = true
                btnMonthly.isHidden = false
            }
            viewDayContainer.isHidden = false
        } else {
            btnWeekly.isHidden = false
            btnMonthly.isHidden = false
            viewDayContainer.isHidden = true
        }
        changedTypeHandler()
    }
    
    @IBAction private func onPressedDay(_ sender: UIButton) {
        dayTapHandler()
    }
    
    @IBAction private func onPressedClear(_ sender: UIButton) {
        clearDaysHandler()
    }
    
}
