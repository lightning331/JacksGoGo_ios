//
//  JGGServiceAnnotationView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/14/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MapKit

class JGGServiceAnnotationView: MKAnnotationView {

    weak var calloutView: JGGCallOutView?
    
    override var annotation: MKAnnotation? {
        willSet {
            calloutView?.removeFromSuperview()
        }
    }
    
    /// Animation duration in seconds.
    
    let animationDuration: TimeInterval = 0.25
    
    // MARK: - Initialization methods
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        canShowCallout = false
        
        image = UIImage(named: "icon_pin")
//        centerOffset = CGPoint(x: -15, y:0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    // MARK: - Show and hide callout as needed
    
    // If the annotation is selected, show the callout; if unselected, remove it
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.calloutView?.removeFromSuperview()
            
            let calloutView = JGGCallOutView(annotation: annotation as! JGGServiceModel)
            calloutView.add(to: self)
            self.calloutView = calloutView
            
            if animated {
                calloutView.alpha = 0
                UIView.animate(withDuration: animationDuration) {
                    calloutView.alpha = 1
                }
            }
            image = UIImage(named: "icon_pin_selected")
        } else {
            guard let calloutView = calloutView else { return }
            
            if animated {
                UIView.animate(withDuration: animationDuration, animations: {
                    calloutView.alpha = 0
                }, completion: { finished in
                    calloutView.removeFromSuperview()
                })
            } else {
                calloutView.removeFromSuperview()
            }
            image = UIImage(named: "icon_pin")
        }
    }
    
    // Make sure that if the cell is reused that we remove it from the super view.
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        calloutView?.removeFromSuperview()
    }
    
    // MARK: - Detect taps on callout
    
    // Per the Location and Maps Programming Guide, if you want to detect taps on callout,
    // you have to expand the hitTest for the annotation itself.
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, with: event) { return hitView }
        
        if let calloutView = calloutView {
            let pointInCalloutView = convert(point, to: calloutView)
            return calloutView.hitTest(pointInCalloutView, with: event)
        }
        
        return nil
    }

}
