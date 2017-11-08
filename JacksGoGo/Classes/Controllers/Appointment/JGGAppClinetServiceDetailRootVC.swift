//
//  JGGAppClinetServiceDetailRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit

class JGGAppClinetServiceDetailRootVC: JGGAppointmentsBaseVC {

    @IBOutlet weak var viewTitleBox: UIView!
    @IBOutlet weak var imgviewCategoryIcon: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblServiceTime: UILabel!

    @IBOutlet weak var containerView: UIView!
    
    var selectedAppointment: JGGAppointmentBaseModel?
    
    private var menu: AZDropdownMenu!
    
    private var isEditJobMode: Bool = false
    
    var currentChildViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = " "
        createMenu()
        showCategoryAndTitle()
        
        loadServiceDetailVC()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.JGGOrange
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.JGGOrange]
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.hidesBarsOnSwipe = false
    }

    private func showCategoryAndTitle() {
        lblTitle.text = "Gardening"
        lblServiceTime.text = "21 Jul, 2017 10:00 AM - 12:00 PM"
        
        if selectedAppointment?.type == .jobs {
            self.navigationItem.rightBarButtonItem = nil
        }
        
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
            if !self.isEditJobMode {
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "button_more_orange")
            }
        }
        self.menu = menu
    }
    
    // MARK: Menu
    @IBAction func onPressedMenu(_ sender: UIBarButtonItem) -> Void {
        if isEditJobMode {
            
            if let editJobNC = currentChildViewController as? JGGEditJobNC,
                editJobNC.viewControllers.count > 1
            {
                editJobNC.popToRootViewController(animated: true)
            } else {
                isEditJobMode = false
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "button_more_orange")
                loadServiceDetailVC()
            }
        } else {
            if self.menu.isDescendant(of: self.view) {
                self.menu.hideMenu()
            } else {
                self.menu.showMenuFromView(self.view, offsetY: self.topLayoutGuide.length)
                sender.image = UIImage(named: "button_more_orange_active")
            }
        }
    }
    
    private func onPressedMenuEdit() {
        print("Pressed Edit")
        if loadEditJobSummaryVC() {
            isEditJobMode = true
            self.navigationItem.rightBarButtonItem?.image = UIImage(named: "button_tick_grey")
        }
    }
    
    private func onPressedMenuDelete() {
        print("Pressed Delete")
        JGGAlertViewController.show(title: LocalizedString("Delete Job?"),
                                    message: LocalizedString("Deleted jobs can be found in Appointment, under History tab."),
                                    colorSchema: .red,
                                    okButtonTitle: LocalizedString("Delete"),
                                    okAction: {
                                        print("Delete Job")
                                        self.navigationController?.popToRootViewController(animated: true)
        },
                                    cancelButtonTitle: LocalizedString("Cancel")) {
                                        
        }
    }

    // MARK: - Load Sub ViewControllers
    
    fileprivate func replaceViewController(to vc: UIViewController) -> Bool{
        if let currentVC = currentChildViewController {
            if object_getClass(vc) == object_getClass(currentVC) {
                return false
            }
            currentVC.removeFromParentViewController()
            currentVC.view.removeFromSuperview()
        }
        self.addChildViewController(vc)
        self.containerView.addSubview(vc.view)
        vc.view.snp.makeConstraints { (maker) in
            maker.left.top.right.bottom.equalToSuperview()
        }
        currentChildViewController = vc
        return true
    }
    
    fileprivate func loadServiceDetailVC() {
        let serviceDetailVC = JGGAppClientServiceDetailVC()
        serviceDetailVC.selectedAppointment = self.selectedAppointment
        _ = replaceViewController(to: serviceDetailVC)
    }
    
    fileprivate func loadEditJobSummaryVC() -> Bool {
        let editJobStoryboard = UIStoryboard(name: "EditJob", bundle: nil)
        if let editJobNC = editJobStoryboard.instantiateInitialViewController() as? JGGEditJobNC {
            return replaceViewController(to: editJobNC)
        } else {
            return false
        }
    }
    
    // MARK: Button actions
    
    /// Open Map
    @objc fileprivate func onPressedMapLocation(_ sender: UIButton) {
        if let mapLocationVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGLocationMapVC") {
            self.navigationController?.pushViewController(mapLocationVC, animated: true)
        }
    }
    
    /// View Original Service Post
    @objc fileprivate func onPressedViewOriginalServicePost(_ sender: UIButton) {
        let vc = JGGServiceDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
