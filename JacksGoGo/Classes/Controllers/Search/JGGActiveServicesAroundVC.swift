//
//  JGGActiveServicesAroundVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MapKit

class JGGActiveServicesAroundVC: JGGSearchBaseVC,
UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var constraintBottomSpaceOfBottomView: NSLayoutConstraint?
    @IBOutlet weak var constraintTopSpaceOfTopView: NSLayoutConstraint?
    @IBOutlet weak var tableView: UITableView?
    
    fileprivate var isShowBottomBar: Bool = true
    
    @IBOutlet weak var btnPostNewService: UIButton!
    @IBOutlet weak var viewListFilterBox: UIView!
    @IBOutlet weak var btnByDistance: UIButton!
    @IBOutlet weak var btnByRatings: UIButton!
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnMapView: UIButton!
    
    @IBOutlet weak var viewMapFilterBox: UIView!
    @IBOutlet weak var lblServices: UILabel!
    @IBOutlet weak var viewMapContainer: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnMapFilter: UIButton!
    @IBOutlet weak var btnListView: UIButton!
    @IBOutlet weak var btnUserLocation: UIButton!
    @IBOutlet weak var lblSearchRadius: UILabel!
    @IBOutlet weak var sliderSearchRadius: UISlider!
    
    var selectedCategory: JGGCategoryModel?
    var isMyServices: Bool = false
    
    fileprivate lazy var appointments: [JGGJobModel] = []
    fileprivate lazy var isLoading: Bool = false
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.viewMapFilterBox.isHidden = true
        self.viewMapContainer.isHidden = true
        
        self.mapView.delegate = self
        
        loadServices()
    }
    
    private func initTableView() {
        self.tableView?.register(UINib(nibName: "JGGServiceListCell", bundle: nil),
                                 forCellReuseIdentifier: "JGGServiceListCell")
        
        self.tableView?.register(UINib(nibName: "JGGLoadingCell", bundle: nil),
                                 forCellReuseIdentifier: "JGGLoadingCell")

        self.tableView?.estimatedRowHeight = 138
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.separatorStyle = .none
        self.tableView?.allowsSelection = true
        
    }
    
    func shouldHideNavigationBarManually() -> Bool {
        return true
    }
    
    // MARK: - Api requests
    fileprivate func loadServices(pageIndex: Int = 0, pageSize: Int = 20) {
        
        let categoryId = selectedCategory?.id
        var userProfileId: String? = nil
        if isMyServices {
            userProfileId = appManager.currentUser?.id
        }
        isLoading = true
        self.tableView?.reloadData()
        APIManager.searchServices(userProfileId: userProfileId, categoryId: categoryId) { [weak self] appointments in
            
            self?.isLoading = false
            
            if pageIndex == 0 {
                self?.appointments.removeAll()
            }
            self?.appointments.append(contentsOf: appointments)
            self?.tableView?.reloadData()
            
        }
        
    }
    
    // MARK: - Button actions
    
    @IBAction func onPressedViewMap(_ sender: Any) {
        self.tableView?.isHidden = true
        self.viewListFilterBox.isHidden = true
        self.viewMapContainer.isHidden = false
        self.viewMapFilterBox.isHidden = false

    }
    
    @IBAction func onPressedListView(_ sender: Any) {
        self.tableView?.isHidden = false
        self.viewListFilterBox.isHidden = false
        self.viewMapContainer.isHidden = true
        self.viewMapFilterBox.isHidden = true
    }
    
    @IBAction func onPressedFilter(_ sender: UIButton) {
        self.performSegue(withIdentifier: "gotoFilterVC", sender: self)
    }
    
    @IBAction func onPressedUserLocation(_ sender: Any) {
        
    }
    
    @IBAction func onChangeSearchRadius(_ sender: Any) {
        let distance = sliderSearchRadius.value * 100
        if distance < 1000 {
            lblSearchRadius.text = String(format: "%d m", Int(distance))
        } else {
            lblSearchRadius.text = String(format: "%.1f km", distance / 1000)
        }
    }

    // MARK: - UITableViewDataSource, delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count + (isLoading ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= appointments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGLoadingCell") as! JGGLoadingCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "JGGServiceListCell") as! JGGServiceListCell
            cell.appointment = appointments[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < self.appointments.count  {
            gotoServiceDetailVC(with: self.appointments[indexPath.row])
        }
    }

    // MARK: ScrollView Delegate
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.changeTabBar(hidden: true, animated: true)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        else{
            self.changeTabBar(hidden: false, animated: true)
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    private func changeTabBar(hidden: Bool, animated: Bool) {
        if (!hidden && isShowBottomBar) || (hidden && !isShowBottomBar) {
            return
        }
        isShowBottomBar = !hidden
        if hidden {
            self.constraintBottomSpaceOfBottomView?.constant = 50
            self.constraintTopSpaceOfTopView?.constant = -80
        } else {
            self.constraintBottomSpaceOfBottomView?.constant = 0
            self.constraintTopSpaceOfTopView?.constant = 0
        }
        updateConstraint()
    }
    
    // MARK: - MKMapView datasource, delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        if let serviceAppointment = annotation as? JGGServiceModel {
            let customAnnotationViewIdentifier = "MyAnnotation"
            
            var pin = mapView.dequeueReusableAnnotationView(withIdentifier: customAnnotationViewIdentifier) as? JGGServiceAnnotationView
            if pin == nil {
                pin = JGGServiceAnnotationView(annotation: serviceAppointment, reuseIdentifier: customAnnotationViewIdentifier)
                
            } else {
                pin?.annotation = annotation
            }
            return pin
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("mapView(_:annotationView:calloutAccessoryControlTapped)")
    }
    
    //MARK: - Navigation
    fileprivate func gotoServiceDetailVC(with service: JGGJobModel) {
        let jobsStoryboard = UIStoryboard(name: "Services", bundle: nil)
        let detailVC = jobsStoryboard.instantiateViewController(withIdentifier: "JGGOriginalServiceDetailVC") as! JGGOriginalServiceDetailVC
        detailVC.service = service
        self.navigationController?
            .pushViewController(detailVC, animated: true)
    }
}
