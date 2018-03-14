//
//  JGGJobDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import AFDateHelper

class JGGJobDetailVC: JGGAppointmentDetailBaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnViewOriginalJobPost: UIButton!
    
    var job: JGGJobModel?
    override var selectedAppointment: JGGJobModel? {
        didSet {
            job = selectedAppointment
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGDetailInfoAccessoryButtonCell")
        registerCell(nibName: "JGGDetailInfoCenterAlignCell")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
        
        
    }
    
    @IBAction func onPressedViewOriginalJob(_ sender: Any) {
        
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

extension JGGJobDetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0, 1, 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
            if row == 0 {
                cell.icon = UIImage(named: "icon_budget")
                if let budgetFrom = job?.budgetFrom, let budgetTo = job?.budgetTo {
                    let str = String(format: "$ %.2f - $ %.2f", budgetFrom, budgetTo)
                    cell.lblTitle.attributedText = str.toBold(strings: [str])
                } else if let budget = job?.budget {
                    let str = String(format: "$ %.2f", budget)
                    cell.lblTitle.attributedText = str.toBold(strings: [str])
                } else {
                    cell.lblTitle.text = nil
                }
            }
            else if row == 1 {
                cell.icon = UIImage(named: "icon_info")
                cell.lblTitle.text = job?.description_
            }
            else if row == 3 {
                cell.icon = UIImage(named: "icon_completion")
                let str = LocalizedString("Requests ") + job!.reportTypeName!
                cell.lblTitle.attributedText = str.toBold(strings: ["Requests"])
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoAccessoryButtonCell") as! JGGDetailInfoAccessoryButtonCell
            cell.icon = UIImage(named: "icon_location")
            cell.lblTitle.text = job?.address?.fullName
            cell.btnAccessory.setImage(UIImage(named: "button_location_green"), for: .normal)
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoCenterAlignCell") as! JGGDetailInfoCenterAlignCell
            cell.lblTitle.text = LocalizedString("Job reference no.: ") + job!.id!
            cell.lblSubTitle.text = "Posted on " + ((job?.postOn?.toString(format: .custom("d MMM, yyyy"))) ?? "")
            return cell
        default:
            break
        }
        
        return UITableViewCell()
    }
}
