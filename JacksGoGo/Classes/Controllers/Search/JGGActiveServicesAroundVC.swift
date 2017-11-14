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
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        self.navigationController?.hidesBarsOnSwipe = true
        self.viewMapFilterBox.isHidden = true
        self.viewMapContainer.isHidden = true
        
        addDummyPin()
        self.mapView.delegate = self
    }
    
    private func initTableView() {
        self.tableView?.register(UINib(nibName: "JGGServiceListCell", bundle: nil),
                                 forCellReuseIdentifier: "JGGServiceListCell")
        
        self.tableView?.estimatedRowHeight = 138
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.separatorStyle = .none
        self.tableView?.allowsSelection = true
        
    }
    
    func shouldHideNavigationBarManually() -> Bool {
        return true
    }
    
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGServiceListCell") as! JGGServiceListCell
        
        return cell
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
    
    private func addDummyPin() {
        let service00 = JGGServiceModel()
        service00.coordinate = CLLocationCoordinate2DMake(1.0008, 103.3545)
        service00.name = "Tennis Coach"
        let client00 = JGGClientUserModel()
        client00.fullname = "Alan.Tam"
        service00.invitingClient = client00
        self.mapView.addAnnotation(service00)
        
        let service01 = JGGServiceModel()
        service01.coordinate = CLLocationCoordinate2DMake(2.0038, 114.4545)
        service01.name = "Gardening"
        let client01 = JGGClientUserModel()
        client01.fullname = "SeanYong"
        service01.invitingClient = client01
        self.mapView.addAnnotation(service01)

//        let region = MKCoordinateRegionMake(service00.coordinate, MKCoordinateSpan(latitudeDelta: 200, longitudeDelta: 200))
        self.mapView.setCenter(service00.coordinate, animated: true)
//        self.mapView.showAnnotations(self.mapView.annotations, animated: false)
    }

}
