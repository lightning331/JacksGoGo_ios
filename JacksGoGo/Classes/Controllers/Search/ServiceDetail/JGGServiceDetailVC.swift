//
//  JGGServiceDetailTVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGServiceDetailVC: JGGSearchBaseTableVC {
    
    var isCanBuyService: Bool = false
    
    fileprivate var imgviewServiceAvatar: UIImageView!
    fileprivate var btnRequestAQuotation: UIButton!
    fileprivate var btnFavorite: UIBarButtonItem!
    fileprivate var btnMenu: UIBarButtonItem!
    
    private var isFavorited: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigationBar()
        initTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.JGGGreen
        
    }
    
    private func initNavigationBar() {
        
        self.navigationItem.title = " "
        
        let btnFavorite = UIBarButtonItem(image: UIImage(named: "button_favourite_outline_orange"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(onPressedFavorite(_:)))
        btnFavorite.tintColor = UIColor.JGGGreen
        self.btnFavorite = btnFavorite
        
        let btnMenu = UIBarButtonItem(image: UIImage(named: "button_more_orange"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onPressedMenu(_:)))
        btnMenu.tintColor = UIColor.JGGGreen
        self.btnMenu = btnMenu
        
        self.navigationItem.rightBarButtonItems = [btnMenu, btnFavorite]
        self.hidesBottomBarWhenPushed = true
    }
    
    private func initTableView() {
        
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero,
                                                  size: CGSize(width: self.view.bounds.width,
                                                               height: self.view.bounds.width * 0.7)))
        imageView.image = UIImage(named: "carousel02.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        self.tableView.tableHeaderView = imageView
        self.imgviewServiceAvatar = imageView
        
        let btnRequestAQuotation = UIButton(type: .custom)
        btnRequestAQuotation.frame = CGRect(origin: CGPoint.zero,
                                            size: CGSize(width: self.view.bounds.width,
                                                         height: 50))
        btnRequestAQuotation.titleLabel?.font = UIFont.JGGButton
        btnRequestAQuotation.backgroundColor = UIColor.JGGGreen
        btnRequestAQuotation.setTitleColor(UIColor.JGGWhite, for: .normal)
        if isCanBuyService {
            btnRequestAQuotation.setTitle(LocalizedString("Buy Service"), for: .normal)
        } else {
            btnRequestAQuotation.setTitle(LocalizedString("Request A Quotation"), for: .normal)
        }
        btnRequestAQuotation.addTarget(self,
                                       action: #selector(onPressedRequestAQuotation(_:)),
                                       for: .touchUpInside)
        self.tableView.tableFooterView = btnRequestAQuotation
        self.btnRequestAQuotation = btnRequestAQuotation
        
        func registerHeaderFooterView(nibName: String) {
            self.tableView.register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: nibName)
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
    
    // MARK: - Button actions

    @objc fileprivate func onPressedFavorite(_ sender: UIBarButtonItem) {
        isFavorited = !isFavorited
        if isFavorited {
            sender.image = UIImage(named: "button_favourite_active_orange")
        } else {
            sender.image = UIImage(named: "button_favourite_outline_orange")
        }
    }
    
    @objc fileprivate func onPressedMenu(_ sender: UIBarButtonItem) {
        
    }
    
    @objc fileprivate func onPressedViewTimeSlots(_ sender: UIButton) {
        let serviceStroyboard = UIStoryboard(name: "Services", bundle: nil)
        let timeSlotsVC = serviceStroyboard.instantiateViewController(withIdentifier: "JGGServiceDetailTimeSlotsVC") as! JGGServiceDetailTimeSlotsVC
        self.navigationController?.pushViewController(timeSlotsVC, animated: true)
    }
    
    @objc fileprivate func onPressedSeeAllReviews(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func onPressedRequestAQuotation(_ sender: UIButton) {
        if isCanBuyService {
            
        } else {
            
        }
    }
    
    @objc fileprivate func onPressedLocation(_ sender: UIButton) {
        let appointmentStroyboard = UIStoryboard(name: "Appointment", bundle: nil)
        let locationMapVC = appointmentStroyboard.instantiateViewController(withIdentifier: "JGGLocationMapVC") as! JGGLocationMapVC
        self.navigationController?.pushViewController(locationMapVC, animated: true)
    }
    
    @objc fileprivate func onPressedViewAllServices(_ sender: UIButton) {
        let serviceStroyboard = UIStoryboard(name: "Services", bundle: nil)
        let allServicesVC = serviceStroyboard.instantiateViewController(withIdentifier: "JGGActiveServicesAroundVC") as! JGGActiveServicesAroundVC
        self.navigationController?.pushViewController(allServicesVC, animated: true)
    }
}

extension JGGServiceDetailVC {
    
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
