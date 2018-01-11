//
//  JGGCallOutView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/14/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MapKit

class JGGCallOutView: UIView {

    weak var annotation: JGGServiceModel?

    private let inset = UIEdgeInsets(top: 5, left: 5, bottom: 10, right: 5)

    private let bubbleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.JGGWhite.cgColor
        layer.shadowColor = UIColor.JGGGrey1.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.8
        return layer
    }()
    
    var contentView: JGGServiceCallOutContentView!
    
    var mapView: MKMapView? {
        var view = superview
        while view != nil {
            if let mapView = view as? MKMapView { return mapView }
            view = view?.superview
        }
        return nil
    }
    
    init(annotation: JGGServiceModel) {
        self.annotation = annotation
        
        super.init(frame: .zero)
        
        configureContentView(annotation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configure the view.
    
    private func configureContentView(_ serviceModel: JGGServiceModel) {
        translatesAutoresizingMaskIntoConstraints = false
        
        contentView = UINib(nibName: "JGGServiceCallOutContentView", bundle: nil)
            .instantiate(withOwner: self, options: nil)[0] as! JGGServiceCallOutContentView
        
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: inset.top),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset.bottom - inset.right / 2.0 + 2),
            contentView.leftAnchor.constraint(equalTo: leftAnchor, constant: inset.left),
            contentView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            contentView.widthAnchor.constraint(greaterThanOrEqualToConstant: inset.left + inset.right),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: inset.top + inset.bottom)
            ])
        
        addBackgroundButton(to: contentView)
        
        layer.insertSublayer(bubbleLayer, at: 0)
        
        contentView.lblServiceTitle.text = serviceModel.title
        contentView.lblPrice.text = String(format: "$ %.02f", 50.0)
        contentView.ratebar.rating = 4.6
        contentView.lblUsername.text = serviceModel.invitingClient?.fullname
    }
    
    
    // if the view is resized, update the path for the callout bubble
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updatePath()
    }
    
    // Override hitTest to detect taps within our callout bubble
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let contentViewPoint = convert(point, to: contentView)
        return contentView.hitTest(contentViewPoint, with: event)
    }
    
    /// Update `UIBezierPath` for callout bubble
    ///
    /// The setting of the bubblePointerType dictates whether the pointer at the bottom of the
    /// bubble has straight lines or whether it has rounded corners.
    
    private func updatePath() {
        let path = UIBezierPath()
        
        var point: CGPoint
        
        var controlPoint: CGPoint
        
        point = CGPoint(x: bounds.size.width - inset.right, y: bounds.size.height - inset.bottom)
        path.move(to: point)
        
        let angle: CGFloat = CGFloat.pi / 4
        // lower right
        point = CGPoint(x: bounds.size.width / 2.0 + tan(angle) * inset.bottom, y: bounds.size.height - inset.bottom)
        path.addLine(to: point)
        
        // right side of arrow
        point = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height)
        path.addLine(to: point)
        
        // left of pointer
        point = CGPoint(x: bounds.size.width / 2.0 - tan(angle) * inset.bottom, y: bounds.size.height - inset.bottom)
        path.addLine(to: point)
        
        // bottom left
        point.x = inset.left
        path.addLine(to: point)
        
        // lower left corner
        controlPoint = CGPoint(x: 0, y: bounds.size.height - inset.bottom)
        point = CGPoint(x: 0, y: controlPoint.y - inset.left)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // left
        point.y = inset.top
        path.addLine(to: point)
        
        // top left corner
        controlPoint = CGPoint.zero
        point = CGPoint(x: inset.left, y: 0)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // top
        point = CGPoint(x: bounds.size.width - inset.left, y: 0)
        path.addLine(to: point)
        
        // top right corner
        
        controlPoint = CGPoint(x: bounds.size.width, y: 0)
        point = CGPoint(x: bounds.size.width, y: inset.top)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        // right
        
        point = CGPoint(x: bounds.size.width, y: bounds.size.height - inset.bottom - inset.right)
        path.addLine(to: point)
        
        // lower right corner
        
        controlPoint = CGPoint(x:bounds.size.width, y: bounds.size.height - inset.bottom)
        point = CGPoint(x: bounds.size.width - inset.right, y: bounds.size.height - inset.bottom)
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        path.close()
        
        bubbleLayer.path = path.cgPath
    }
    
    /// Add this `CalloutView` to an annotation view (i.e. show the callout on the map above the pin)
    ///
    /// - Parameter annotationView: The annotation to which this callout is being added.
    
    func add(to annotationView: MKAnnotationView) {
        annotationView.addSubview(self)
        
        // constraints for this callout with respect to its superview
        
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: annotationView.topAnchor, constant: annotationView.calloutOffset.y),
            centerXAnchor.constraint(equalTo: annotationView.centerXAnchor, constant: annotationView.calloutOffset.x)
            ])
    }

}

extension JGGCallOutView {
    
    fileprivate func addBackgroundButton(to view: UIView) {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        button.addTarget(self, action: #selector(didTouchUpInCallout(_:)), for: .touchUpInside)
    }
    
    @objc func didTouchUpInCallout(_ sender: Any) {
        // this is intentionally blank
    }
}

