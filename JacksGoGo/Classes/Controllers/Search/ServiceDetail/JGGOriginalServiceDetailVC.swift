//
//  JGGServiceDetailTVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGOriginalServiceDetailVC: JGGSearchBaseTableVC {
    
    var service: JGGJobModel! {
        didSet {
            if let _ = service.budget {
                isCanBuyService = true
            }
        }
    }
    
    fileprivate lazy var isCanBuyService: Bool = false

    fileprivate var imgviewServiceAvatar: UIImageView!
    @IBOutlet fileprivate var btnRequestAQuotation: UIButton!
    @IBOutlet fileprivate var btnFavorite: UIBarButtonItem!
    @IBOutlet fileprivate var btnMenu: UIBarButtonItem!
    
    private var isFavorited: Bool = false
    private var menu: AZDropdownMenu!
    fileprivate lazy var serviceStroyboard = UIStoryboard(name: "Services", bundle: nil)
    fileprivate lazy var appointmentStroyboard = UIStoryboard(name: "Appointment", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initTableView()
        
        if service.userProfileId == appManager.currentUser?.id {
            self.tableView.tableFooterView = nil
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.JGGGreen
        
    }
    
    private func initNavigationBar() {
        
        self.navigationItem.title = " "
        
        createMenu()
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBottomBarWhenPushed = true

    }
    
    private func initTableView() {
        
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero,
                                                  size: CGSize(width: self.view.bounds.width,
                                                               height: self.view.bounds.width * 0.7)))
        imageView.image = nil
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.tableView.tableHeaderView = imageView
        self.imgviewServiceAvatar = imageView
        
        if isCanBuyService {
            btnRequestAQuotation.setTitle(LocalizedString("Buy Service"), for: .normal)
        } else {
            btnRequestAQuotation.setTitle(LocalizedString("Request A Quotation"), for: .normal)
        }
        
        func registerCell(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        }
        
        registerCell(nibName: "JGGDetailCategoryTitleCell")
        registerCell(nibName: "JGGDetailInfoDescriptionCell")
        registerCell(nibName: "JGGDetailInfoAccessoryButtonCell")
        registerCell(nibName: "JGGTimeSlotsAvailableCell")
        registerCell(nibName: "JGGTotalReviewCell")
        registerCell(nibName: "JGGAppInviteProviderCell")
        registerCell(nibName: "JGGTagListCell")
        registerCell(nibName: "JGGJobBookedInfoCell")
        
    }
    
    // MARK: Create Menu
    
    private func createMenu() {
        var menuDataSource: [AZDropdownMenuItemData] = []
        menuDataSource.append(AZDropdownMenuItemData(title:LocalizedString("Share"),
                                                     icon:UIImage(named: "icon_share_green")!))
        menuDataSource.append(AZDropdownMenuItemData(title:LocalizedString("Report Service"),
                                                     icon:UIImage(named: "icon_flag_green")!))
        
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
    @IBAction fileprivate func onPressedMenu(_ sender: UIBarButtonItem) {
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
        JGGAlertViewController.show(title: LocalizedString("Report Service"),
                                    message: LocalizedString("Mark this post as inappropriate or offensive."),
                                    colorSchema: .green,
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
                                    colorSchema: .green,
                                    okButtonTitle: LocalizedString("Done"),
                                    okAction: { text in
                                        
        },
                                    cancelButtonTitle: nil,
                                    cancelAction: nil)
    }

    // MARK: - Button actions

    @IBAction fileprivate func onPressedFavorite(_ sender: UIBarButtonItem) {
        isFavorited = !isFavorited
        if isFavorited {
            sender.image = UIImage(named: "button_favourite_active_orange")
        } else {
            sender.image = UIImage(named: "button_favourite_outline_orange")
        }
    }
    
    @objc fileprivate func onPressedViewTimeSlots(_ sender: UIButton) {
        let timeSlotsVC = serviceStroyboard.instantiateViewController(withIdentifier: "JGGServiceDetailTimeSlotsVC") as! JGGServiceDetailTimeSlotsVC
        self.navigationController?.pushViewController(timeSlotsVC, animated: true)
    }
    
    @objc fileprivate func onPressedSeeAllReviews(_ sender: UIButton) {
        let allReviewsVC = serviceStroyboard.instantiateViewController(withIdentifier: "JGGAllReviewsVC") as! JGGAllReviewsVC
        self.navigationController?.pushViewController(allReviewsVC, animated: true)
    }
    
    @IBAction fileprivate func onPressedRequestAQuotation(_ sender: UIButton) {
        if isCanBuyService {
            let serviceBuyVC = serviceStroyboard.instantiateViewController(withIdentifier: "JGGServiceBuyVC") as! JGGServiceBuyVC
            self.navigationController?.pushViewController(serviceBuyVC, animated: true)
        } else {
            
            let requestQuotationVC = serviceStroyboard.instantiateViewController(withIdentifier: "JGGRequestQuotationVC") as! JGGRequestQuotationVC
            self.navigationController?.pushViewController(requestQuotationVC, animated: true)
            
        }
    }
    
    @objc fileprivate func onPressedLocation(_ sender: UIButton) {
        let locationMapVC = appointmentStroyboard.instantiateViewController(withIdentifier: "JGGLocationMapVC") as! JGGLocationMapVC
        self.navigationController?.pushViewController(locationMapVC, animated: true)
    }
    
    @objc fileprivate func onPressedViewAllServices(_ sender: UIButton) {
        let allServicesVC = serviceStroyboard.instantiateViewController(withIdentifier: "JGGActiveServicesAroundVC") as! JGGActiveServicesAroundVC
        self.navigationController?.pushViewController(allServicesVC, animated: true)
    }
}

extension JGGOriginalServiceDetailVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailCategoryTitleCell") as! JGGDetailCategoryTitleCell
            
            return cell
        case 1, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoDescriptionCell") as! JGGDetailInfoDescriptionCell
            if indexPath.row == 1 {
                cell.icon = UIImage(named: "icon_budget")
                cell.title = "$ 80.00 - $ 110.00"
                cell.lblTitle.font = UIFont.JGGListTitle
            }
            else if indexPath.row == 2 {
                cell.icon = UIImage(named: "icon_info")
                cell.title = "We are experts at gardening & landscaping. Please state in your quotation: size of your garden, what tasks you need done, and any special requirements."
                cell.lblTitle.font = UIFont.JGGListText
            }
                return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGDetailInfoAccessoryButtonCell") as! JGGDetailInfoAccessoryButtonCell
            cell.icon = UIImage(named: "icon_location")
            cell.title = "Smith Street, 0.4km away"
            cell.lblTitle.font = UIFont.JGGListText
            if isCanBuyService {
                cell.btnAccessory.isHidden = false
                cell.btnAccessory.addTarget(self, action: #selector(onPressedLocation(_:)), for: .touchUpInside)
            } else {
                cell.btnAccessory.isHidden = true
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTimeSlotsAvailableCell") as! JGGTimeSlotsAvailableCell
            cell.btnViewTimeSlots.addTarget(self,
                                            action: #selector(onPressedViewTimeSlots(_:)),
                                            for: .touchUpInside)
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTotalReviewCell") as! JGGTotalReviewCell
            cell.btnSeeAllReviews.addTarget(self,
                                            action: #selector(onPressedSeeAllReviews(_:)),
                                            for: .touchUpInside)
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppInviteProviderCell") as! JGGAppInviteProviderCell
            if isCanBuyService {
                cell.btnInvite.setTitle(LocalizedString("View All Services"), for: .normal)
                cell.btnInvite.addTarget(self, action: #selector(onPressedViewAllServices(_:)), for: .touchUpInside)
            } else {
                cell.btnInvite.isHidden = true
            }
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTagListCell") as! JGGTagListCell
            cell.taglistView.removeAllTags()
            cell.taglistView.addTags([
                "gardening", "landscaping", "harticulture", "plants", "garden", "garderner", "training"
                ])
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGJobBookedInfoCell") as! JGGJobBookedInfoCell
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
