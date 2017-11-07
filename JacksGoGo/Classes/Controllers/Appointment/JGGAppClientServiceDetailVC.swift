//
//  JGGAppClientServiceDetailVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/3/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppClientServiceDetailVC: JGGAppointmentsBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var viewTitleBox: UIView!
    @IBOutlet weak var imgviewCategoryIcon: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblServiceTime: UILabel!
    
    var jobDetailHeaderView: JGGDetailInfoHeaderView?
    
    
    fileprivate let SECTION_PROVIDER: Int = 0
    fileprivate let SECTION_JOB_DETAIL: Int = 1
    
    fileprivate var isExandedJobDetail = false
    
    private var menu: AZDropdownMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMenu()
        showCategoryAndTitle()
        initTableView()
    }
    
    private func showCategoryAndTitle() {
        lblTitle.text = "Gardening"
        lblServiceTime.text = "21 Jul, 2017 10:00 AM - 12:00 PM"
    }
    
    private func initTableView() {
        
        let headerView = UINib(nibName: "JGGNextStepTitleView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? JGGNextStepTitleView
        headerView?.title = LocalizedString("Wating for service provider...")
        self.tableView.tableHeaderView = headerView
        
        func registerHeaderFooterView(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: nibName)
        }
        
        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        registerHeaderFooterView(nibName: "JGGSectionTitleView")
        registerHeaderFooterView(nibName: "JGGDetailInfoHeaderView")
        registerHeaderFooterView(nibName: "JGGDetailInfoFooterView")
        
        registerCell(nibName: "JGGUserAvatarNameRateCell")
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGDetailInfoAccessoryButtonCell")
        registerCell(nibName: "JGGDetailInfoCenterAlignCell")
        registerCell(nibName: "JGGImageCarouselCell")
        registerCell(nibName: "JGGBorderButtonCell")
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: Create Menu
    
    private func createMenu() {
        var menuDataSource: [AZDropdownMenuItemData] = []
        menuDataSource.append(AZDropdownMenuItemData(title:LocalizedString("Edit"),
                                                     icon:UIImage(named: "button_edit_orange")!))
        menuDataSource.append(AZDropdownMenuItemData(title:LocalizedString("Delete"),
                                                     icon:UIImage(named: "button_delete_orange")!))
        
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
                self?.onPressedMenuEdit()
            } else if indexPath.row == 1 { // Delete
                self?.onPressedMenuDelete()
            }
        }
        menu.hiddenCompleteHandler = {
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "button_more_orange")
        }
        self.menu = menu
    }
    
    @IBAction func onPressedMenu(_ sender: UIBarButtonItem) -> Void {
        if self.menu.isDescendant(of: self.view) {
            self.menu.hideMenu()
        } else {
            self.menu.showMenuFromView(self.view, offsetY: self.topLayoutGuide.length) //, offsetY: self.navigationController?.navigationBar.frame.height)
            sender.image = UIImage(named: "button_more_orange_active")
        }
    }
    
    private func onPressedMenuEdit() {
        print("Pressed Edit")
    }
    
    private func onPressedMenuDelete() {
        print("Pressed Delete")
        JGGAlertViewController.show(title: LocalizedString("Delete Job?"),
                                    message: LocalizedString("Deleted jobs can be found in Appointment, under History tab."),
                                    colorSchema: .red,
                                    okButtonTitle: LocalizedString("Delete"),
                                    okAction: {
                                        print("Delete Job")
                                    },
                                    cancelButtonTitle: LocalizedString("Cancel")) {
                                        
                                    }
    }
}

extension JGGAppClientServiceDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    /// Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == SECTION_PROVIDER {
            return 40
        }
        else if section == SECTION_JOB_DETAIL {
            return 70
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == SECTION_PROVIDER {
            let sectionTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGSectionTitleView") as? JGGSectionTitleView
            sectionTitleView?.title = LocalizedString("Invited service provider:")
            return sectionTitleView
        }
        else if section == SECTION_JOB_DETAIL {
            let jobDetailHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGDetailInfoHeaderView") as? JGGDetailInfoHeaderView
            jobDetailHeaderView?.btnExpand.isSelected = isExandedJobDetail
            jobDetailHeaderView?.btnExpand.addTarget(self, action: #selector(onPressExpand(_:)), for: .touchUpInside)
            self.jobDetailHeaderView = jobDetailHeaderView
            return jobDetailHeaderView
        } else {
            return nil
        }
    }
    
    // Footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == SECTION_PROVIDER {
            return 0
        }
        else if section == SECTION_JOB_DETAIL {
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == SECTION_JOB_DETAIL {
            let jobDetailFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGDetailInfoFooterView") as? JGGDetailInfoFooterView
            jobDetailFooterView?.text = "Job posted on 12 Jul, 2017 8:16 PM"
            return jobDetailFooterView
        } else {
            return nil
        }
    }
    
    
    /// Cell
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION_PROVIDER {
            return 1
        }
        else if section == SECTION_JOB_DETAIL {
            if let jobDetailHeaderView = jobDetailHeaderView,
                jobDetailHeaderView.btnExpand.isSelected == true {
                return 7
            } else {
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        if section == SECTION_PROVIDER {
            let providerCell = tableView.dequeueReusableCell(withIdentifier: "JGGUserAvatarNameRateCell") as! JGGUserAvatarNameRateCell
            providerCell.lblUsername.text = "Alan.Tam"
            return providerCell
        }
        else if section == SECTION_JOB_DETAIL {
            if row == 0 {
                let carouselViewCell = tableView.dequeueReusableCell(withIdentifier: "JGGImageCarouselCell") as! JGGImageCarouselCell
                carouselViewCell.imgviewJobSummary.image = UIImage(named: "carousel01.jpg")
//                carouselViewCell.carouselView.delegate = self
//                carouselViewCell.carouselView.type = .normal
//                carouselViewCell.carouselView.selectedIndex = 0
                return carouselViewCell
            }
            else if row == 1 || row == 2 || row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
                if row == 1 {
                    cell.icon = UIImage(named: "icon_budget")
                    cell.title = "$ 10.00 - $ 100.00"
                    cell.lblTitle.font = UIFont.JGGListTitle
                }
                else if row == 2 {
                    cell.icon = UIImage(named: "icon_info")
                    cell.title = "We are experts at gardening & landscaping. Please state in your quotation: size of your garden, what tasks you need done, and any special requirement"
                    cell.lblTitle.font = UIFont.JGGListText
                }
                else if row == 4 {
                    cell.icon = UIImage(named: "icon_completion")
                    let requestsString = LocalizedString("Requests:")
                    let text = requestsString + " " + "Before & After photos"
                    let attributes = [ NSAttributedStringKey.font : UIFont.JGGListTitle ]
                    let regularAttributes = [ NSAttributedStringKey.font : UIFont.JGGListText ]
                    let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
                    let regularRange = NSRange(location: requestsString.count, length: text.count - requestsString.count)
                    attributedString.addAttributes(regularAttributes, range: regularRange)
                    cell.lblTitle.attributedText = attributedString
                }
                return cell
            }
            else if row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoAccessoryButtonCell") as! JGGDetailInfoAccessoryButtonCell
                cell.icon = UIImage(named: "icon_location")
                cell.title = "2 Jurong West Avenue 5 6437327"
                cell.lblTitle.font = UIFont.JGGListText
                return cell
            }
            else if row == 5 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoCenterAlignCell") as! JGGDetailInfoCenterAlignCell
                cell.title = LocalizedString("Job reference no:") + " " + "J39482-2934882"
                cell.subTitle = LocalizedString("Posted on") + " " + "12 Jul, 2017"
                return cell
            }
            else if row == 6 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "JGGBorderButtonCell") as! JGGBorderButtonCell
                cell.buttonTitle = LocalizedString("View Original Servicce Post")
                cell.btnPrimary.borderColor = UIColor.JGGGreen
                cell.btnPrimary.setTitleColor(UIColor.JGGGreen, for: .normal)
                return cell
            }
        }
        
        return UITableViewCell()
    }

    /// Expand job detail
    @objc func onPressExpand(_ sender: Any) {
        isExandedJobDetail = !isExandedJobDetail
        if let button = sender as? UIButton {
            button.isSelected = isExandedJobDetail
        }
        self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}

extension JGGAppClientServiceDetailVC: TGLParallaxCarouselDelegate  {
    func numberOfItemsInCarouselView(_ carouselView: TGLParallaxCarousel) -> Int {
        return 3
    }
    
    func carouselView(_ carouselView: TGLParallaxCarousel, itemForRowAtIndex index: Int) -> TGLParallaxCarouselItem {
        return JGGCarouselImageView(frame: carouselView.bounds)
    }
    
    func carouselView(_ carouselView: TGLParallaxCarousel, willDisplayItem item: TGLParallaxCarouselItem, forIndex index: Int) {
        if let imageView = item as? JGGCarouselImageView {
            let fileName = String(format: "carousel%02d.jpg", index + 1)
            imageView.imageView.image = UIImage(named: fileName)
        }
    }
    
    func carouselView(_ carouselView: TGLParallaxCarousel, didSelectItemAtIndex index: Int) {
        
    }
}
