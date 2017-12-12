
//
//  JGGAppDetailBaseVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit

class JGGAppDetailBaseVC: JGGAppointmentsBaseVC, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var viewCategoryName: UIView!
    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnMenu: UIBarButtonItem?
    
    var selectedAppointment: JGGAppointmentBaseModel?

    private var menu: AZDropdownMenu!
    
    private var isEditJobMode: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false

        createMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        if self.menu.isDescendant(of: self.view) {
            self.menu.hideMenu()
        } else {
            self.menu.showMenuFromView(self.view, offsetY: self.topLayoutGuide.length)
            sender.image = UIImage(named: "button_more_orange_active")
        }
        /*
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
            
        } */
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
                                        self.navigationController?.popToRootViewController(animated: true)
        },
                                    cancelButtonTitle: LocalizedString("Cancel")) {
                                        
        }
    }

    
    // MARK: - UITableView datasource, delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
