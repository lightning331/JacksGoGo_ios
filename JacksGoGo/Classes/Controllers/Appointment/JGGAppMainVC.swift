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
    
    fileprivate lazy var arrayLoadedQuickJobs: [JGGJobModel] = []
    fileprivate lazy var arrayLoadedServicePackages: [JGGServicePackageModel] = []
    fileprivate lazy var arrayLoadedPendingJobs: [JGGAppointmentBaseModel] = []
    
    fileprivate lazy var searchResultQuickJobs: [JGGJobModel] = []
    fileprivate lazy var searchResultServicePackages: [JGGServicePackageModel] = []
    fileprivate lazy var searchResultPendingJobs: [JGGAppointmentBaseModel] = []
    fileprivate var isSearchMode: Bool = false
    
    fileprivate var arrayQuickJobs: [JGGJobModel] {
        return isSearchMode == true ? searchResultQuickJobs : arrayLoadedQuickJobs
    }
    fileprivate var arrayServicePackages: [JGGServicePackageModel] {
        return isSearchMode == true ? searchResultServicePackages : arrayLoadedServicePackages
    }
    fileprivate var arrayPendingJobs: [JGGAppointmentBaseModel] {
        return isSearchMode == true ? searchResultPendingJobs : arrayLoadedPendingJobs
    }

    fileprivate var selectedTab: AppointmentTabButton = .pending
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        makeTemporaryData()

        initializeTableView()
        addTabNavigationBar()
        addSearchField()
        registerCell()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.hidesBarsOnSwipe = true
        
    }
        
    private func initializeTableView() {
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.allowsSelection = true

    }

    private func addTabNavigationBar() {
        if let view = UINib(nibName: "JGGAppHomeTabView", bundle: nil).instantiate(withOwner: self, options: nil).first as? JGGAppHomeTabView {
            let size = self.navigationController!.navigationBar.bounds.size
            let frame = CGRect(origin: CGPoint.zero, size: size)
            view.frame = frame
            self.navigationItem.titleView = view
            view.delegate = self
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
        self.tableView.register(UINib(nibName: "JGGAppHistoryListCell", bundle: nil),
                                forCellReuseIdentifier: "JGGAppHistoryListCell")
        self.tableView.register(UINib(nibName: "JGGSectionTitleView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "JGGSectionTitleView")
    }
    
    // MARK: - UITableView Data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if selectedTab == .pending {
            return 3
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if selectedTab == .pending {
            return 50
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppHistoryListCell") as! JGGAppHistoryListCell
        if indexPath.section == 0 {
            if selectedTab == .pending {
                cell.appointment = arrayQuickJobs[indexPath.row];
            } else {
                let index = Int(arc4random_uniform(UInt32(indexPath.row)))
                cell.appointment = arrayPendingJobs[index];
            }
        } else if indexPath.section == 1 {
            cell.appointment = arrayServicePackages[indexPath.row];
        } else if indexPath.section == 2 {
            cell.appointment = arrayPendingJobs[indexPath.row];
        }
        return cell
    }
    
    // MARK: delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! JGGAppHistoryListCell
        if let serviceDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGAppClinetServiceDetailRootVC") as? JGGAppClinetServiceDetailRootVC {
            serviceDetailVC.selectedAppointment = cell.appointment
            self.navigationController?.pushViewController(serviceDetailVC, animated: true)
        }
    }
    
    // MARK: - Should remove on Product
    
    private func makeTemporaryData() {
        let quickJob00 = JGGJobModel()
        quickJob00.title = "Fast Food Delivery"
        quickJob00.status = .pending
        quickJob00.comment = "Needed before 12:00 PM"
        quickJob00.appointmentDate = Date(timeInterval: 5000, since: Date())
        arrayLoadedQuickJobs.append(quickJob00)
        
        let servicePack00 = JGGServicePackageModel()
        servicePack00.title = "Fast Food Delivery"
        servicePack00.comment = "1 slot remaining"
        arrayLoadedServicePackages.append(servicePack00)
        
        let pendingJob00 = JGGJobModel()
        pendingJob00.title = "Bring My Dog To Her Grooming Apartment"
        pendingJob00.comment = "Needed on 21 Jul, 2017"
        pendingJob00.badgeNumber = 3
        pendingJob00.appointmentDate = Date(timeInterval: 23000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob00)
        
        let pendingJob01 = JGGServiceModel()
        pendingJob01.title = "Maid Needed"
        pendingJob01.comment = "Needed on 18 Jul, 2017"
        pendingJob01.badgeNumber = 1
        pendingJob01.appointmentDate = Date(timeInterval: 127000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob01)
        
        let pendingJob02 = JGGJobModel()
        pendingJob02.title = "Delivery - Small Parcel"
        pendingJob02.comment = "Needed on 19 Jul, 2017"
        pendingJob02.appointmentDate = Date(timeInterval: 232000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob02)
        
        let pendingJob03 = JGGEventModel()
        pendingJob03.title = "Badminton Gathering"
        pendingJob03.comment = "We love Badminton\nEvent on 19 Jul, 2017 10:00 AM - 12:00 PM"
        pendingJob03.appointmentDate = Date(timeInterval: 339000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob03)
        
        let pendingJob04 = JGGJobModel()
        pendingJob04.title = "Gardening - Small Garden"
        pendingJob04.comment = "Needed from 10:00 AM - 12: PM"
        pendingJob04.appointmentDate = Date(timeInterval: 441000, since: Date())
        pendingJob04.status = .cancelled
        arrayLoadedPendingJobs.append(pendingJob04)
        
        let pendingJob05 = JGGJobModel()
        pendingJob05.title = "Bring My Dog To Her Grooming Apartment"
        pendingJob05.comment = "Needed on 21 Jul, 2017"
        pendingJob05.badgeNumber = 222
        pendingJob05.appointmentDate = Date(timeInterval: 559000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob05)
        
        let pendingJob06 = JGGServiceModel()
        pendingJob06.title = "Bring My Dog To Her Grooming Apartment"
        pendingJob06.comment = "Needed on 21 Jul, 2017"
        pendingJob06.appointmentDate = Date(timeInterval: 666000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob06)
        
        let pendingJob07 = JGGJobModel()
        pendingJob07.title = "Bring Grooming Apartment"
        pendingJob07.comment = "Needed on 21 Jul, 2017"
        pendingJob07.appointmentDate = Date(timeInterval: 772000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob07)
        
        let pendingJob08 = JGGEventModel()
        pendingJob08.title = "Bring My Dog To Her Grooming Apartment"
        pendingJob08.comment = "Independent event\nEvent on 16 Jul, 2017 10:00 AM - 12:00 PM"
        pendingJob08.appointmentDate = Date(timeInterval: 893000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob08)
        
        let pendingJob09 = JGGJobModel()
        pendingJob09.title = "Bring My Dog"
        pendingJob09.comment = "Needed on 21 Jul, 2017"
        pendingJob09.appointmentDate = Date(timeInterval: 999000, since: Date())
        arrayLoadedPendingJobs.append(pendingJob09)
        
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
