//
//  JGGServiceMainVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSearchMainVC: JGGStartTableVC {

    @IBOutlet weak var viewJobSummary: UIView!
    @IBOutlet weak var lblTotalJobsCount: UILabel!
    @IBOutlet weak var lblNewJobsCount: UILabel!
    @IBOutlet weak var btnViewAllJobs: UIButton!
    @IBOutlet weak var btnPostNewJob: UIButton!
    
    
    @IBOutlet weak var viewServiceSummary: UIView!
    @IBOutlet weak var lblTotalServiceCounts: UILabel!
    @IBOutlet weak var lblNewServiceCounts: UILabel!
    @IBOutlet weak var btnViewMyServices: UIButton!
    @IBOutlet weak var btnViewAllServices: UIButton!
    @IBOutlet weak var btnPostNewService: UIButton!
    @IBOutlet weak var clsviewAllCategories: UICollectionView!
    @IBOutlet weak var constraintCategoriesHeight: NSLayoutConstraint!
    
    fileprivate lazy var categories: [JGGCategoryModel] = []
    
    private var selectedTab: SearchTabButton = .services
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        categories = appManager.categories
        addTabNavigationBar()
        initTableView()
        initCollectionView()
        self.viewServiceSummary.isHidden = false
        self.viewJobSummary.isHidden = true
    }
    
    override func showLoginVCIfNeed() -> Bool {
        return false
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
        
        let cellSize = categoryCellSize(for: UIScreen.main.bounds.size.width - 32, margin: 8)
        var rowCount = 0
        if UIScreen.main.bounds.size.width <= 375 {
            rowCount = (categories.count + 2) / 3
        } else {
            rowCount = (categories.count + 3) / 4
        }
        let headerHeight = self.clsviewAllCategories.frame.origin.y + ((cellSize.height + 8) * CGFloat(rowCount))
        self.constraintCategoriesHeight.constant = headerHeight - self.clsviewAllCategories.frame.origin.y
        var frame = self.tableView.tableHeaderView!.frame
        frame.size.height = headerHeight
        self.tableView.tableHeaderView?.frame = frame
        
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "gotoPostJob" || identifier == "gotoPostService" {
            guard let _ = appManager.currentUser else {
                JGGAlertViewController.show(title: LocalizedString("Information"),
                                            message: LocalizedString("You can't perform this action because didn't login. Would you login to proceed this?"),
                                            colorSchema: .orange,
                                            okButtonTitle: LocalizedString("Login"),
                                            okAction: {
                                                self.navigationController?.tabBarController?.selectedIndex = 4
                                            },
                                            cancelButtonTitle: LocalizedString("Cancel"),
                                            cancelAction: nil)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "gotoPostService" {
                let selectSkillVC = segue.destination as! JGGSelectSkillVC
                selectSkillVC.verifiedSkills = [
                    JGGCategoryModel(),
                    JGGCategoryModel(),
                ]
            }
        }
    }
}

extension JGGSearchMainVC: JGGSearchHomeTabViewDelegate {
    func searchHomeTabView(_ view: JGGSearchHomeTabView, selectedButton: SearchTabButton) {
        if selectedButton == .search {
            
            let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
            let searchVC = searchStoryboard.instantiateViewController(withIdentifier: "JGGSearchVC") as! JGGSearchVC
            self.navigationController?.pushViewController(searchVC, animated: true)
            return
        } else if selectedButton == .services {
            self.viewServiceSummary.isHidden = false
            self.viewJobSummary.isHidden = true
            
        } else if selectedButton == .jobs {
            self.viewServiceSummary.isHidden = true
            self.viewJobSummary.isHidden = false
        }
        self.selectedTab = selectedButton;
        self.tableView.reloadData()
        self.clsviewAllCategories.reloadData()
    }
}

extension JGGSearchMainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGSearchCategorySelectCell", for: indexPath) as! JGGSearchCategorySelectCell
        cell.category = categories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = categoryCellSize(for: collectionView.frame.width - 32, margin: 8)
        return cellSize
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
        if self.selectedTab == .services {
            cell.imgviewAccessory.image = UIImage(named: "button_next_green")
        } else if self.selectedTab == .jobs {
            cell.imgviewAccessory.image = UIImage(named: "button_next_cyan")
        }
        cell.viewAddress.isHidden = (indexPath.row == 2)
        cell.viewBooked.isHidden = (indexPath.row == 4 || indexPath.row == 8)
        if indexPath.row == 3 {
            cell.lblServiceTitle.text = "Tennis Coach - Pricate Lessons 1 on 1 for 2 hours"
        } else {
            cell.lblServiceTitle.text = "Lifeguard Training"
        }
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
