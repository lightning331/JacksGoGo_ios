//
//  JGGAppJobStatusSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppJobStatusSummaryVC: JGGAppDetailBaseVC {

    @IBOutlet weak var constraintBottomSpaceOfTableView: NSLayoutConstraint!
    @IBOutlet weak var viewChatProposalBox: UIView!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnViewProposal: UIButton!
    @IBOutlet weak var lblChatBadge: UILabel!
    @IBOutlet weak var imgviewProviderAvatar: UIImageView!
    @IBOutlet weak var lblProviderName: UILabel!
    
    @IBOutlet weak var headviewButtons: UIView!
    @IBOutlet weak var btnJobReport: UIButton!
    @IBOutlet weak var btnInvoice: UIButton!
    @IBOutlet weak var btnReview: UIButton!
    @IBOutlet weak var btnTip: UIButton!
    @IBOutlet weak var btnRehire: UIButton!
    
    private var cellCount: Int = 9

    var job: JGGJobModel!
    
    /**
     * 0: Just posted,
     * 1: confirmed appointment,
     * 2: started work,
     * 3: to verify job report,
     * 4: verified work,
     * 5: released payment,
     * 7: client review,
     * 8: provider review
     **/
    private var currentJobStatus: Int = 0

    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.JGGOrange

        initTableView()

        showJobInformation()
        
        if job.status == .open {
            
        } else if job.status == .confirmed {
            
        } else if job.status == .closed {
            
        }
    }

    private func initTableView() {
        
        self.tableView.register(UINib(nibName: "JGGAppJobStatusCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppJobStatusCell")
        self.tableView.register(UINib(nibName: "JGGAppJobStatusAccessoryCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppJobStatusAccessoryCell")
        self.tableView.register(UINib(nibName: "JGGAppJobStatusButtonCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppJobStatusButtonCell")
        self.tableView.register(UINib(nibName: "JGGAppJobStatusPromptCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppJobStatusPromptCell")
    }
    
    private func showJobInformation() {
        if let category = job.category {
            if let urlString = category.image, let url = URL(string: urlString) {
                self.imgviewCategory.af_setImage(withURL: url, placeholderImage: nil)
            }
        }
        self.lblTitle.text = job.title
//        var timeString: String = ""
        
    }
    
    override func onPressedMenuEdit() {
        
    }
    
    override func onPressedMenuDelete() {
        print("Pressed Delete")
        JGGAlertViewController.show(title: LocalizedString("Delete Job?"),
                                    message: LocalizedString("Let the providers know why you are cancelling the job."),
                                    colorSchema: .red,
                                    textFieldPlaceholder: LocalizedString("Reason"),
                                    okButtonTitle: LocalizedString("Delete"),
                                    okAction: { text in
                                        print("Delete Job")
                                        self.navigationController?.popToRootViewController(animated: true)
                                    },
                                    cancelButtonTitle: LocalizedString("Cancel"))
    }
    
    // MARK: - API request
    
    
    // MARK: - UITableView datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let statusIndex = cellCount - indexPath.row - 1
        if statusIndex == 0 {
            // Posted this job in Jobs
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusCell") as! JGGAppJobStatusCell
            cell.setType(.posted,
                         time: Date(timeIntervalSinceNow: -3000),
                         isActive: false,
                         text: LocalizedString("You posted this job in Jobs"),
                         boldStrings: nil)
            return cell
        } else if statusIndex == 1 {
            // Waiting provider or quotations
            if true { // quotations.count > 0
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusButtonCell") as! JGGAppJobStatusButtonCell
                cell.setType(.watingProvider,
                             time: Date(timeIntervalSinceNow: -2990),
                             isActive: false,
                             text: LocalizedString("You have received 5 quotations!"),
                             boldStrings: [LocalizedString("You have received 5 quotations!")])
                
                cell.buttonTitle = LocalizedString("View Quotations")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusCell") as! JGGAppJobStatusCell
                cell.setType(.watingProvider,
                             time: Date(timeIntervalSinceNow: -2990),
                             isActive: false,
                             text: LocalizedString("Waiting for Service Providers to respond..."),
                             boldStrings: [LocalizedString("Waiting for Service Providers to respond...")])

                return cell
            }
        } else if statusIndex == 2 {
            // appointment confirmed
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusCell") as! JGGAppJobStatusCell
            cell.setType(.appointment,
                         time: Date(timeIntervalSinceNow: -2500),
                         isActive: false,
                         text: LocalizedString("Appointment Confirmed.\nWe'll drop  you a notification a day before your appointment."),
                         boldStrings: [LocalizedString("Appointment Confirmed.")])
            return cell
        } else if statusIndex == 3 {
            // started work
            if true {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusPromptCell") as! JGGAppJobStatusPromptCell
                cell.setType(.appointment,
                             time: Date(timeIntervalSinceNow: -1500),
                             isActive: false,
                             text: String(format: "%@ %@", "catherinedesilva", LocalizedString("has started the work.")),
                             boldStrings: ["catherinedesilva"])
                cell.prompt(content: "Grass Seeds", price: 35.00)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusCell") as! JGGAppJobStatusCell
                cell.setType(.appointment,
                             time: Date(timeIntervalSinceNow: -1500),
                             isActive: false,
                             text: String(format: "%@ %@", "catherinedesilva", LocalizedString("has started the work.")),
                             boldStrings: ["catherinedesilva"])
                return cell
            }
        } else if statusIndex == 4 {
            // completed work
            if true {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusButtonCell") as! JGGAppJobStatusButtonCell
                cell.setType(.none,
                             time: Date(timeIntervalSinceNow: -1400),
                             isActive: true,
                             text: String(format: "%@ %@", "catherinedesilva", LocalizedString("has completed the work.")),
                             boldStrings: ["catherinedesilva"])
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusCell") as! JGGAppJobStatusCell
                cell.setType(.none,
                             time: Date(timeIntervalSinceNow: -1400),
                             isActive: true,
                             text: String(format: "%@ %@", "catherinedesilva", LocalizedString("has completed the work.")),
                             boldStrings: ["catherinedesilva"])
                return cell

            }
        } else if statusIndex == 5 {
            // completed work
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusCell") as! JGGAppJobStatusCell
            cell.setType(.verified,
                         time: Date(timeIntervalSinceNow: -1200),
                         isActive: true,
                         text: LocalizedString("You have verified the work."),
                         boldStrings: [])
            return cell
        } else if statusIndex == 6 {
            // released money
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusCell") as! JGGAppJobStatusCell
            cell.setType(.cost,
                         time: Date(timeIntervalSinceNow: -900),
                         isActive: false,
                         text: String(format: LocalizedString("You have given %@ a tip of $%.02f"), "catherinedesilva", 20.0),
                         boldStrings: ["catherinedesilva", "$20.00"])
            return cell
        } else if statusIndex == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusAccessoryCell") as! JGGAppJobStatusAccessoryCell
            cell.setType(.information,
                         time: Date(timeIntervalSinceNow: -800),
                         isActive: false,
                         text: String(format: LocalizedString("%@ has given you a reivew"), "catherinedesilva"),
                         boldStrings: ["catherinedesilva"])
            return cell
        } else if statusIndex == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppJobStatusAccessoryCell") as! JGGAppJobStatusAccessoryCell
            cell.setType(.information,
                         time: Date(timeIntervalSinceNow: -700),
                         isActive: false,
                         text: String(format: LocalizedString("You have given %@ a reivew"), "catherinedesilva"),
                         boldStrings: ["catherinedesilva"])
            return cell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.updateConstraintsIfNeeded()
        
    }
    
    // MARK: - Button actions
    
    fileprivate func onPressedViewQuotations(_ sender: UIButton) {
        
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

