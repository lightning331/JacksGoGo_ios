//
//  JGGSelectLocationMapVC.swift
//  JacksGoGo
//
//  Created by Chris Lin on 3/21/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import MapKit

class JGGSelectLocationMapVC: JGGViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var loadingAddress: UIActivityIndicatorView!

    var selectedLocationHandler:((CLPlacemark?, CLLocationCoordinate2D) -> Void)?
    var currentCoordinate = CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198) // Singapore
    fileprivate var currentPlacemark: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.delegate = self
        
        // Zoom in to current location
        
        let region = MKCoordinateRegion(
            center: currentCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
        mapView.setRegion(region, animated: true)
        
        // Add tap handler
        let tapMap = UITapGestureRecognizer(target: self, action: #selector(tapMapView(_:)))
        tapMap.numberOfTapsRequired = 1
        tapMap.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(tapMap)
        
        lblLocationName.font = UIFont.JGGListTitle
    }
    
    @IBAction fileprivate func onPressedCancel(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction fileprivate func onPressedDone(_ sender: Any) {
        selectedLocationHandler?(currentPlacemark, currentCoordinate)
        self.navigationController?.dismiss(animated: true, completion: nil)
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

// MARK: - MKMapView delegate
extension JGGSelectLocationMapVC: MKMapViewDelegate {
    
    @objc fileprivate func tapMapView(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: mapView)
        let tapCoordinate = mapView.convert(point, toCoordinateFrom: mapView)
        let tapAnnotation = MKPointAnnotation()
        tapAnnotation.coordinate = tapCoordinate
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(tapAnnotation)
        currentCoordinate = tapCoordinate
        self.getAddressName(from: tapCoordinate)
    }
    
    fileprivate func getAddressName(from coordinate: CLLocationCoordinate2D) {
        
        let coordinateString = String(format: "%.4fº N, %.4fº E", coordinate.latitude, coordinate.longitude)
        lblLocationName.text = coordinateString
        
        loadingAddress.startAnimating()
        let geo = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geo.reverseGeocodeLocation(location) { (placemarks, error) in
            self.loadingAddress.stopAnimating()
            guard let placemark = placemarks?.first else {
                return
            }
            self.currentPlacemark = placemark
            let formattedAddress = (placemark.addressDictionary?["FormattedAddressLines"] as? [String])?.joined(separator: ", ")
            self.lblLocationName.text = (formattedAddress ?? "") + "\n" + coordinateString
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        if let _ = annotation as? MKPointAnnotation {
            let customAnnotationViewIdentifier = "locationAnnotation"
            
            var pin = mapView.dequeueReusableAnnotationView(withIdentifier: customAnnotationViewIdentifier)
            if pin == nil {
                pin = MKAnnotationView(annotation: annotation, reuseIdentifier: customAnnotationViewIdentifier)
                pin?.image = UIImage(named: "icon_pin")
            } else {
                pin?.annotation = annotation
            }
            return pin
        } else {
            return nil
        }
    }
    
}
