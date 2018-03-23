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
    
    fileprivate var sectionTitleView: JGGSectionTitleButtonView?
    
    fileprivate lazy var categories: [JGGCategoryModel] = []
    
    private var selectedTab: SearchTabButton = .services
    private var isLoadingServices: Bool = false {
        didSet {
            if selectedTab == .services {
                sectionTitleView?.startLoading(isLoadingServices)
            }
        }
    }
    private var isLoadingJobs: Bool = false {
        didSet {
            if selectedTab == .jobs {
                sectionTitleView?.startLoading(isLoadingJobs)
            }
        }
    }
    fileprivate var arrayRecommendServices: [JGGJobModel] = []
    fileprivate var arrayRecommendJobs: [JGGJobModel] = []
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        categories = appManager.categories
        addTabNavigationBar()
        initTableView()
        initCollectionView()
        self.viewServiceSummary.isHidden = false
        self.viewJobSummary.isHidden = true
        
        loadRecommendServices()
        loadRecommendJobs()
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
        self.tableView.register(UINib(nibName: "JGGSectionTitleButtonView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "JGGSectionTitleButtonView")
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
    
    // MARK: - Request to load services and jobs
    
    fileprivate func loadRecommendServices(pageIndex: Int = 0, pageSize: Int = 20) {
        if isLoadingServices { return }
        isLoadingServices = true
        APIManager.searchServices { (result) in
            self.isLoadingServices = false
            if pageIndex == 0 {
                self.arrayRecommendServices.removeAll()
            }
            self.arrayRecommendServices.append(contentsOf: result)
            if self.selectedTab == .services {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func loadRecommendJobs(pageIndex: Int = 0, pageSize: Int = 20) {
        if isLoadingJobs { return }
        isLoadingJobs = true
        APIManager.searchJobs { (result) in
            self.isLoadingJobs = false
            if pageIndex == 0 {
                self.arrayRecommendJobs.removeAll()
            }
            self.arrayRecommendJobs.append(contentsOf: result)
            if self.selectedTab == .jobs {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc fileprivate func reloadRecommendAppointments(_ sender: Any) {
        if selectedTab == .services {
            loadRecommendServices()
        } else if selectedTab == .jobs {
            loadRecommendJobs()
        }
    }
    
    // MARK: - Button actions
    
    @IBAction func onPressedViewMyServices(_ sender: Any) {
    }
    
    @IBAction func onPressedViewAll(_ sender: Any) {
        
    }
    
    @IBAction func onPressedPostNew(_ sender: Any) {
        
    }
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "gotoPostJob" || identifier == "gotoPostService" {
            guard let _ = appManager.currentUser else {
                JGGAlertViewController.show(title: LocalizedString("Information"),
                                            message: LocalizedString("You can't perform this action because didn't login. Would you login to proceed this?"),
                                            colorSchema: .orange,
                                            okButtonTitle: LocalizedString("Login"),
                                            okAction: { text in
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
        let sectionTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGSectionTitleButtonView") as? JGGSectionTitleButtonView
        sectionTitleView?.title = LocalizedString("Recommended For You")
        var imageName: String = "button_reload_green"
        if self.selectedTab == .services {
            if isLoadingServices {
                sectionTitleView?.loadingIndicator.startAnimating()
            }
        } else if self.selectedTab == .jobs {
            imageName = "button_reload_cyan"
            if isLoadingJobs {
                sectionTitleView?.loadingIndicator.startAnimating()
            }
        } else if self.selectedTab == .goclub {
            imageName = "button_reload_purple"
        }
        sectionTitleView?.button.setImage(
            UIImage(named: imageName),
            for: .normal
        )
        sectionTitleView?.button.addTarget(
            self,
            action: #selector(reloadRecommendAppointments(_:)),
            for: .touchUpInside
        )
        self.sectionTitleView = sectionTitleView
        return sectionTitleView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRecommendAppointments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGServiceListCell") as! JGGServiceListCell
        if self.selectedTab == .services {
            cell.imgviewAccessory.image = UIImage(named: "button_next_green")
        } else if self.selectedTab == .jobs {
            cell.imgviewAccessory.image = UIImage(named: "button_next_cyan")
        }
        cell.appointment = arrayRecommendAppointments[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let _ = appManager.currentUser else {
            return
        }
        let appointment = arrayRecommendAppointments[indexPath.row]
        if self.selectedTab == .services {
            gotoServiceDetailVC(with: appointment)
        } else if self.selectedTab == .jobs {
            gotoJobDetailVC(with: appointment)
        } else if self.selectedTab == .goclub {
            
        }
        
    }
    
    private var arrayRecommendAppointments: [JGGJobModel] {
        set {
            if self.selectedTab == .services {
                arrayRecommendServices = newValue
            } else if self.selectedTab == .jobs {
                arrayRecommendJobs = newValue
            } else if self.selectedTab == .goclub {
                
            }
        }
        get {
            if self.selectedTab == .services {
                return arrayRecommendServices
            } else if self.selectedTab == .jobs {
                return arrayRecommendJobs
            } else if self.selectedTab == .goclub {
                return []
            } else {
                return []
            }
        }
    }
    
    private func gotoServiceDetailVC(with service: JGGJobModel) {
        let jobsStoryboard = UIStoryboard(name: "Services", bundle: nil)
        let detailVC = jobsStoryboard.instantiateViewController(withIdentifier: "JGGOriginalServiceDetailVC") as! JGGOriginalServiceDetailVC
        detailVC.service = service
        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
    
    private func gotoJobDetailVC(with job: JGGJobModel) {
        let jobsStoryboard = UIStoryboard(name: "Jobs", bundle: nil)
        let detailVC = jobsStoryboard.instantiateViewController(withIdentifier: "JGGOriginalJobDetailVC") as! JGGOriginalJobDetailVC
        detailVC.job = job
        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
}
