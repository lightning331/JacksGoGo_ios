//
//  JGGServiceMainVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSearchMainVC: JGGStartTableVC {

    @IBOutlet weak var lblTotalServiceCounts: UILabel!
    @IBOutlet weak var lblNewServiceCounts: UILabel!
    @IBOutlet weak var btnViewMyServices: UIButton!
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var btnPostNew: UIButton!
    @IBOutlet weak var clsviewAllCategories: UICollectionView!
    
    fileprivate let categories: [[String: String]] = [
        [
            "title": LocalizedString("Favourited Services"),
            "imageName": "icon_cat_favourites",
            ],
        [
            "title": LocalizedString("Cooking & Baking"),
            "imageName": "icon_cat_cooking&baking",
            ],
        [
            "title": LocalizedString("Education"),
            "imageName": "icon_cat_education",
            ],
        [
            "title": LocalizedString("Handyman"),
            "imageName": "icon_cat_handyman",
            ],
        [
            "title": LocalizedString("Household Chores"),
            "imageName": "icon_cat_householdchores",
            ],
        [
            "title": LocalizedString("Messenger"),
            "imageName": "icon_cat_messenger",
            ],
        [
            "title": LocalizedString("Running Man"),
            "imageName": "icon_cat_runningman",
            ],
        [
            "title": LocalizedString("Leisure"),
            "imageName": "icon_cat_leisure",
            ],
        [
            "title": LocalizedString("Social"),
            "imageName": "icon_cat_social",
            ],
        [
            "title": LocalizedString("Sports"),
            "imageName": "icon_cat_runningman",
            ],
        [
            "title": LocalizedString("Event"),
            "imageName": "icon_cat_event",
            ],
        [
            "title": LocalizedString("Exploration"),
            "imageName": "icon_cat_exploration",
            ],
        [
            "title": LocalizedString("Family"),
            "imageName": "icon_cat_family",
            ],
        [
            "title": LocalizedString("Gardening"),
            "imageName": "icon_cat_gardening",
            ],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTabNavigationBar()
        initTableView()
        initCollectionView()
    }

    private func addTabNavigationBar() {
        if let view = UINib(nibName: "JGGSearchHomeTabView", bundle: nil).instantiate(withOwner: self, options: nil).first as? JGGSearchHomeTabView {
            let size = self.navigationController!.navigationBar.bounds.size
            let frame = CGRect(origin: CGPoint.zero, size: size)
            view.frame = frame
            self.navigationItem.titleView = view
            view.delegate = self
        }
    }
    
    private func initTableView() {
        self.tableView.register(UINib(nibName: "JGGSectionTitleView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "JGGSectionTitleView")
        self.tableView.register(UINib(nibName: "JGGServiceListCell", bundle: nil),
                                forCellReuseIdentifier: "JGGServiceListCell")
        self.tableView.allowsSelection = true
    }
    
    private func initCollectionView() {
        self.clsviewAllCategories.register(UINib(nibName: "JGGSearchCategorySelectCell", bundle: nil),
                                           forCellWithReuseIdentifier: "JGGSearchCategorySelectCell")
        self.clsviewAllCategories.dataSource = self
        self.clsviewAllCategories.delegate = self
        
    }
    
    @IBAction func onPressedViewMyServices(_ sender: Any) {
    }
    
    @IBAction func onPressedViewAll(_ sender: Any) {
    }
    
    @IBAction func onPressedPostNew(_ sender: Any) {
    }
    
}

extension JGGSearchMainVC: JGGSearchHomeTabViewDelegate {
    func searchHomeTabView(_ view: JGGSearchHomeTabView, selectedButton: SearchTabButton) {
        
    }
}

extension JGGSearchMainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories.count > 9 {
            return 9
        } else {
            return categories.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGSearchCategorySelectCell", for: indexPath) as! JGGSearchCategorySelectCell
        if indexPath.row == 8 && categories.count > 9 {
            cell.lblTitle.text = LocalizedString("Other Professions")
            cell.imgviewIcon.image = UIImage(named: "icon_cat_other")
        } else {
            let category = categories[indexPath.row]
            cell.lblTitle.text = category["title"]
            cell.imgviewIcon.image = UIImage(named: category["imageName"]!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension JGGSearchMainVC { // UITableViewDataSource, UITableViewDelegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGSectionTitleView") as? JGGSectionTitleView
        sectionTitleView?.title = LocalizedString("Recommended For You")
        return sectionTitleView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGServiceListCell") as! JGGServiceListCell
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoBidDetailVC()
    }
    
    private func gotoBidDetailVC() {
        let detailVC = JGGServiceDetailVC()
        detailVC.isCanBuyService = true
        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
}
