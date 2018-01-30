//
//  JGGPostServiceTimeSlotsTypeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceTimeSlotsTypeVC: JGGPostServiceTimeSlotsBaseVC {

    fileprivate var selectedTimeType: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(true, animated: false)

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
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServiceTimeSlotsTypeCell") as! JGGPostServiceTimeSlotsTypeCell
            cell.selectingHandler = { index in
                if index == 1 {
                    
                    if let parentVC = self.navigationController?.parent as? JGGPostServiceStepRootVC {
                        parentVC.stepView.completeCurrentStep()
                        parentVC.stepView.nextStep()
                    }
                    
                } else {
                    self.selectedTimeType = index
                    self.tableView.reloadData()
                }
            }
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGPostServiceTimeSlotsOptionCell") as! JGGPostServiceTimeSlotsOptionCell
            cell.selectedNowHandler = {
                
            }
            cell.selectedLaterHandler = {
                if let parentVC = self.navigationController?.parent as? JGGPostServiceStepRootVC {
                    parentVC.stepView.completeCurrentStep()
                    parentVC.stepView.nextStep()
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "gotoAddTimeSlotsVC" {
            if self.selectedTimeType == 2 {
                self.navController.selectedPeopleType = .onePerson // One person
            } else if self.selectedTimeType == 3 {
                self.navController.selectedPeopleType = .multiplePeople // Multiple people
            }
        }
    }

}

class JGGPostServiceTimeSlotsTypeCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnNoTimeSlots: JGGYellowSelectingButton!
    @IBOutlet weak var btnOnePerson: JGGYellowSelectingButton!
    @IBOutlet weak var btnMultiplePerson: JGGYellowSelectingButton!
    
    var selectingHandler: ((Int) -> Void)!
    
    @IBAction fileprivate func onPressedButton(_ sender: JGGYellowSelectingButton) {
        
        if sender == btnNoTimeSlots {
            selectingHandler(1)
        } else {
            var index: Int = 0
            sender.select(!sender.selected())
            if sender.selected() {
                self.lblTitle.text = LocalizedString("This will create a service with time slots.")
                if sender == btnOnePerson {
                    index = 2
                    btnNoTimeSlots.isHidden = true
                    btnMultiplePerson.select(false)
                    btnMultiplePerson.isHidden = true
                }
                else if sender == btnMultiplePerson {
                    index = 3
                    btnNoTimeSlots.isHidden = true
                    btnOnePerson.select(false)
                    btnOnePerson.isHidden = true
                }
            } else {
                self.lblTitle.text = LocalizedString("Does your service have time slots available?")
                btnNoTimeSlots.isHidden = false
                btnOnePerson.isHidden = false
                btnMultiplePerson.isHidden = false
            }
            selectingHandler(index)
        }
    }
    
}

class JGGPostServiceTimeSlotsOptionCell: UITableViewCell {
    
    @IBOutlet weak var btnNow: JGGYellowSelectingButton!
    @IBOutlet weak var btnLater: JGGYellowSelectingButton!

    var selectedNowHandler: (() -> Void)!
    var selectedLaterHandler: (() -> Void)!

    @IBAction fileprivate func onPressedNow(_ sender: UIButton) {
        selectedNowHandler()
    }
    
    @IBAction fileprivate func onPressedLater(_ sender: UIButton) {
        selectedLaterHandler()
    }
}
