//
//  JGGAppMainVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppMainVC: JGGStartTableVC {

    fileprivate var searchbar: JGGAppSearchHeaderView?
    
    fileprivate lazy var arrayAllPendingJobs: [JGGJobModel] = []
    
    fileprivate lazy var arrayLoadedQuickJobs: [JGGJobModel] = []
    fileprivate lazy var arrayLoadedServicePackages: [JGGJobModel] = []
    fileprivate lazy var arrayLoadedPendingJobs: [JGGJobModel] = []
    
    fileprivate lazy var searchResultQuickJobs: [JGGJobModel] = []
    fileprivate lazy var searchResultServicePackages: [JGGJobModel] = []
    fileprivate lazy var searchResultPendingJobs: [JGGJobModel] = []
    fileprivate var isSearchMode: Bool = false
    fileprivate var isLoading: Bool = false
    
    fileprivate var arrayQuickJobs: [JGGJobModel] {
        return isSearchMode == true ? searchResultQuickJobs : arrayLoadedQuickJobs
    }
    fileprivate var arrayServicePackages: [JGGJobModel] {
        return isSearchMode == true ? searchResultServicePackages : arrayLoadedServicePackages
    }
    fileprivate var arrayPendingJobs: [JGGJobModel] {
        return isSearchMode == true ? searchResultPendingJobs : arrayLoadedPendingJobs
    }

    fileprivate var selectedTab: AppointmentTabButton = .pending
    
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeTableView()
        addTabNavigationBar()
        addSearchField()
        registerCell()
        
//        self.tableView.es.startPullToRefresh()
    }
    
    private func initializeTableView() {
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.allowsSelection = true
        self.addRefreshControl()
    }

    private func addTabNavigationBar() {
        if let view = UINib(nibName: "JGGAppHomeTabView", bundle: nil).instantiate(withOwner: self, options: nil).first as? JGGAppHomeTabView {
            let size = self.navigationController!.navigationBar.bounds.size
            let frame = CGRect(origin: CGPoint.zero, size: size)
            view.frame = frame
            self.navigationItem.titleView = view
            view.delegate = self
            view.pendingBadge = 0
            view.confirmedBadge = 0
        }
    }
    
    private func addSearchField() {
        let searchfieldView =
            UINib(nibName: "JGGAppSearchHeaderView", bundle: nil)
                .instantiate(withOwner: nil, options: nil)
                .first as? JGGAppSearchHeaderView
        self.tableView.tableHeaderView = searchfieldView
        searchfieldView?.searchBar.delegate = self
        searchbar = searchfieldView
    }
    
    private func registerCell() {
        self.tableView.register(UINib(nibName: "JGGAppHistoryListJobCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppHistoryListJobCell")
        self.tableView.register(UINib(nibName: "JGGAppHistoryListServiceCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppHistoryListServiceCell")
        self.tableView.register(UINib(nibName: "JGGSectionTitleView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "JGGSectionTitleView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoggedIn && self.arrayAllPendingJobs.count == 0 {
//            reloadJobWithPullRefresh()
            self.loggedInHandler(self)
        }
    }
    
    override func loggedInHandler(_ sender: Any) {
//        reloadJobWithPullRefresh()
        self.refreshControl?.beginRefreshing()
        self.tableView.setContentOffset(
            CGPoint(x: 0, y: -self.refreshControl!.frame.height),
            animated: true
        )
        reloadJobWithPullRefresh()
    }
    
    override func loggedOutHandler(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    // MARK: - Load and filter jobs
    fileprivate func resetData() {
        arrayAllPendingJobs.removeAll()
        arrayLoadedQuickJobs.removeAll()
        arrayLoadedServicePackages.removeAll()
        arrayLoadedPendingJobs.removeAll()
        searchResultQuickJobs.removeAll()
        searchResultServicePackages.removeAll()
        searchResultPendingJobs.removeAll()
    }
    
    fileprivate func reloadJobWithPullRefresh() {
        
        if !self.isLoading {
            guard let currentUser = self.appManager.currentUser else {
                return
            }
            self.APIManager.getPendingJobs(user: currentUser) { (response) in
                self.resetData()
                self.arrayAllPendingJobs.append(contentsOf: response)
                self.filterJobs(response)
                self.isLoading = false
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
            self.isLoading = true
        }
    }
    
    override func pullToRefresh(_ sender: Any) {
        reloadJobWithPullRefresh()
    }
    
    fileprivate func loadJobs() {
        guard let currentUser = self.appManager.currentUser else {
            return
        }
        self.APIManager.getPendingJobs(user: currentUser) { (response) in
            self.arrayAllPendingJobs.append(contentsOf: response)
            self.filterJobs(response)
            if response.count > 0 {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func filterJobs(_ jobs: [JGGJobModel]) {
        for job in jobs {
            if job.isQuickJob {
                arrayLoadedQuickJobs.append(job)
            } else if job.isRequest == false && job.appointmentType > 1 {
                arrayLoadedServicePackages.append(job)
            } else {
                arrayLoadedPendingJobs.append(job)
            }
        }
        
    }
    
    // MARK: - UITableView Data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isLoggedIn {
            if selectedTab == .pending {
                return 3
            } else {
                return 1
            }
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isLoggedIn {
            if selectedTab == .pending {
                if section == 0 {
                    if arrayQuickJobs.count == 0 {
                        return 0
                    }
                } else if section == 1 {
                    if arrayServicePackages.count == 0 {
                        return 0
                    }
                } else if section == 2 {
                    if arrayQuickJobs.count == 0 && arrayServicePackages.count == 0 {
                        return 0
                    }
                }
                return 50
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isLoggedIn {
            let sectionTitleView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGSectionTitleView") as? JGGSectionTitleView
            if section == 0 {
                sectionTitleView?.title = LocalizedString("Quick Jobs")
            }
            else if section == 1 {
                sectionTitleView?.title = LocalizedString("Service Packages")
            }
            else if section == 2 {
                sectionTitleView?.title = LocalizedString("Pending Jobs")
            }
            return sectionTitleView
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoggedIn {
            if section == 0 {
                if selectedTab == .pending {
                    return arrayQuickJobs.count
                } else {
                    return arrayPendingJobs.count
                }
            }
            else if section == 1 {
                return arrayServicePackages.count
            }
            else if section == 2 {
                return arrayPendingJobs.count
            }
            else {
                return 0
            }
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoggedIn {
            let cell : JGGAppHistoryListCell!
            if indexPath.section == 0 {
                cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppHistoryListJobCell") as! JGGAppHistoryListCell
                if selectedTab == .pending {
                    cell.job = arrayQuickJobs[indexPath.row];
                } else {
                    let index = Int(arc4random_uniform(UInt32(indexPath.row)))
                    cell.job = arrayPendingJobs[index];
                }
            } else if indexPath.section == 1 {
                cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppHistoryListJobCell") as! JGGAppHistoryListCell
                cell.job = arrayServicePackages[indexPath.row];
            } else if indexPath.section == 2 {
                let job = arrayPendingJobs[indexPath.row];
                if job.isRequest {
                    cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppHistoryListJobCell") as! JGGAppHistoryListCell
                } else {
                    cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppHistoryListServiceCell") as! JGGAppHistoryListCell
                }
                cell.job = job
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppHistoryListJobCell") as! JGGAppHistoryListCell
            }
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    // MARK: delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isLoggedIn {
            let cell = tableView.cellForRow(at: indexPath) as! JGGAppHistoryListCell
            
            var ownJob: Bool = false
            if let currentUser = appManager.currentUser {
                if currentUser.id == cell.job?.userProfileId {
                    ownJob = true
                }
            }
            if ownJob {
                if cell.job!.isRequest {
                    if let appointmentStatusSummary = self.storyboard?.instantiateViewController(withIdentifier: "JGGAppJobStatusSummaryVC") as? JGGAppJobStatusSummaryVC
                    {
                        appointmentStatusSummary.selectedAppointment = cell.job!
                        self.navigationController?.pushViewController(appointmentStatusSummary, animated: true)
                    }
                } else {
                    
                }
            } else {
                
            }
            /*
            if let serviceDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGAppClinetServiceDetailRootVC") as? JGGAppClinetServiceDetailRootVC {
                serviceDetailVC.selectedAppointment = cell.appointment
                self.navigationController?.pushViewController(serviceDetailVC, animated: true)
            } */
            
        } else {
            
        }
    }
    
}

extension JGGAppMainVC: JGGAppHomeTabViewDelegate {
    func appointmentHomeTabView(_ view: JGGAppHomeTabView, selectedButton: AppointmentTabButton) {
        if selectedButton == .filter {
            openFilterOption()
        } else {
            selectedTab = selectedButton
            self.tableView.reloadData()
            self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1),
                                               animated: true)
            var placeholder: String?
            switch selectedButton {
            case .pending:
                placeholder = LocalizedString("Search through Pending list")
                break
            case .confirmed:
                placeholder = LocalizedString("Search through Confirmed list")
                break
            case .history:
                placeholder = LocalizedString("Search through History list")
                break
            default:
                placeholder = nil
                break
            }
            self.searchbar?.searchBar.placeholder = placeholder
        }
    }
    
    private func openFilterOption() {
        let filterOptionVC =
            self.storyboard?
                .instantiateViewController(withIdentifier: "JGGAppFilterVC") as! JGGAppFilterVC
        self.navigationController?.pushViewController(filterOptionVC, animated: true)
    }
}

extension JGGAppMainVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchMode = false
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchByText(searchText)
    }
    
    private func searchByText(_ queryText: String?) {
        isSearchMode = true
        searchResultQuickJobs = arrayLoadedQuickJobs.filter {
            queryText == nil ||
                $0.title?
                    .lowercased()
                    .range(of: queryText!.lowercased()) != nil
        }
            
        searchResultServicePackages = arrayLoadedServicePackages.filter {
            queryText == nil ||
                $0.title?
                    .lowercased()
                    .range(of: queryText!.lowercased()) != nil
        }
        searchResultPendingJobs = arrayLoadedPendingJobs.filter {
            queryText == nil ||
                $0.title?
                    .lowercased()
                    .range(of: queryText!.lowercased()) != nil
        }
        self.tableView.reloadData()
    }
    
}
