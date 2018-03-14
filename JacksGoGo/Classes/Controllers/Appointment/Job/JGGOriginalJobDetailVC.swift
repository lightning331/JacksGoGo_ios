//
//  JGGOriginalJobDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/14/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGOriginalJobDetailVC: JGGAppointmentsTableVC {

    @IBOutlet weak var btnFavorite: UIBarButtonItem!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnMakeProposal: UIButton!
    
    private var isFavorited: Bool = false
    private var menu: AZDropdownMenu!

    var job: JGGJobModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initTableView()
        
    }

    private func initNavigationBar() {
        
        self.navigationItem.title = " "
        
        createMenu()
        
        self.hidesBottomBarWhenPushed = true
    }
    
    private func initTableView() {
        
        
        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        registerCell(nibName: "JGGDetailCategoryTitleCell")
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGDetailInfoAccessoryButtonCell")
        registerCell(nibName: "JGGAppInviteProviderCell")
        registerCell(nibName: "JGGTagListCell")
        registerCell(nibName: "JGGJobResponseCountCell")
        registerCell(nibName: "JGGJobReferencePostedTimeCell")
        registerCell(nibName: "JGGJobBookedInfoCell")
    }

    // MARK: Create Menu
    
    private func createMenu() {
        var menuDataSource: [AZDropdownMenuItemData] = []
        menuDataSource.append(AZDropdownMenuItemData(title:LocalizedString("Share"),
                                                     icon:UIImage(named: "icon_share_cyan")!))
        menuDataSource.append(AZDropdownMenuItemData(title:LocalizedString("Report Service"),
                                                     icon:UIImage(named: "icon_flag_cyan")!))
        
        let menu = AZDropdownMenu(dataSource: menuDataSource)
        menu.itemHeight = 60
        menu.itemFontName = UIFont.JGGListTitle.fontName
        menu.itemFontSize = 15
        menu.overlayColor = UIColor.JGGBlack
        menu.overlayAlpha = 0.5
        menu.itemAlignment = .left
        menu.itemImagePosition = .prefix
        menu.menuSeparatorStyle = .none
        menu.cellTapHandler = { [weak self] (indexPath: IndexPath) -> Void in
            if indexPath.row == 0 { // Edit
                self?.onPressedMenuShare()
            } else if indexPath.row == 1 { // Delete
                self?.onPressedMenuReport()
            }
        }
        menu.hiddenCompleteHandler = {
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "button_more_green")
        }
        self.menu = menu
    }
    
    // MARK: Menu
    @objc fileprivate func onPressedMenu(_ sender: UIBarButtonItem) {
        if self.menu.isDescendant(of: self.navigationController!.view!) {
            self.menu.hideMenu()
        } else {
            let height = UIApplication.shared.statusBarFrame.height +
                self.navigationController!.navigationBar.frame.height
            self.menu.showMenuFromView(self.navigationController!.view!, offsetY: height)
            sender.image = UIImage(named: "button_more_active_green")
        }
    }
    
    private func onPressedMenuShare() {
        
        let activityViewController = UIActivityViewController(activityItems: ["Testing url"], applicationActivities: nil)
        self.navigationController?.present(activityViewController, animated: true, completion: nil)
    }
    
    private func onPressedMenuReport() {
        print("Pressed Report")
        JGGAlertViewController.show(title: LocalizedString("Report Job"),
                                    message: LocalizedString("Mark this post as inappropriate or offensive."),
                                    colorSchema: .cyan,
                                    okButtonTitle: LocalizedString("Report"),
                                    okAction: { text in
                                        self.perform(#selector(self.showReportThankYouAlert(_:)), with: nil, afterDelay: 0.5)
        },
                                    cancelButtonTitle: LocalizedString("Cancel")) { text in
                                        
        }
    }
    
    @objc private func showReportThankYouAlert(_ sender: Any) {
        JGGAlertViewController.show(title: LocalizedString("Thank You!"),
                                    message: LocalizedString("Our team will be looking into the matter."),
                                    colorSchema: .cyan,
                                    okButtonTitle: LocalizedString("Done"),
                                    okAction: { text in
                                        
        },
                                    cancelButtonTitle: nil,
                                    cancelAction: nil)
    }
    
    // MARK: - Button actions
    
    @objc fileprivate func onPressedFavorite(_ sender: UIBarButtonItem) {
        isFavorited = !isFavorited
        if isFavorited {
            sender.image = UIImage(named: "button_favourite_active_orange")
        } else {
            sender.image = UIImage(named: "button_favourite_outline_orange")
        }
    }

    @IBAction func onPressedMakeProposal(_ sender: UIButton) {
        
    }
    

}

extension JGGOriginalJobDetailVC {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        switch row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailCategoryTitleCell") as! JGGDetailCategoryTitleCell
            cell.title = self.job.title
            cell.category = self.job.category
            return cell
        case 1, 2, 3, 4, 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
            var imageName: String = ""
            var desc: String = ""
            var boldStrings: [String] = []
            if row == 1 {
                imageName = "icon_time"
                if job.appointmentType == 1 {
                    desc = LocalizedString("One-time Job")
                } else {
                    desc = LocalizedString("Package Job")
                }
                desc += "\n" + job.jobTimeDescription()
                boldStrings = [desc]
            }
            else if row == 2 {
                imageName = "icon_info"
                desc = job.description_ ?? ""
            }
            else if row == 3 {
                imageName = "icon_location"
                desc = job.address?.fullName ?? ""
            }
            else if row == 4 {
                imageName = "icon_budget"
                if job.budgetType == 0 {
                    desc = LocalizedString("Not set")
                }
                else if job.budgetType == 1 {
                    desc = LocalizedString("No limit")
                }
                else if job.budgetType == 2 {
                    desc = String(format: "%@\n$ %.2f", LocalizedString("Fixed"), job.budget ?? 0)
                }
                else if job.budgetType == 3 {
                    desc = String(format: "%@\n$ %.2f - $ $.2f/month", LocalizedString("Package"), job.budgetFrom ?? 0, job.budgetTo ?? 0)
                }
            }
            else if row == 5 {
                imageName = "icon_completion"
                desc = LocalizedString("Requests: ") + (job.reportTypeName ?? "Not set")
                boldStrings = ["Requests:"]
            }
            cell.icon = UIImage(named: imageName)
            cell.lblTitle.attributedText = desc.toBold(strings: boldStrings)
            
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppInviteProviderCell") as! JGGAppInviteProviderCell
            cell.btnInvite.isHidden = true
            cell.user = job.userProfile
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTagListCell") as! JGGTagListCell
            cell.taglistView.removeAllTags()
            if let tags = job.tags {
                let arrayTags = tags.split(separator: ",").map { String(describing: $0) }
                cell.taglistView.addTags(arrayTags)
            }
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGJobResponseCountCell") as! JGGJobResponseCountCell
            
            return cell
        case 9:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGJobReferencePostedTimeCell") as! JGGJobReferencePostedTimeCell
            cell.lblJobReferenceNo.text = LocalizedString("Job reference no.: ") + (job.id ?? "")
            cell.lblPostTime.text = LocalizedString("Posted on ") + (job.postOn?.toString(format: .custom("d MMM, yyyy")).uppercased() ?? "")
            return cell
        case 10:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGJobBookedInfoCell") as! JGGJobBookedInfoCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }

}
