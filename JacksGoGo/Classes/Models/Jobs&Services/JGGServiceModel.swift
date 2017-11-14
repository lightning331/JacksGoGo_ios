//
//  JGGServiceModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MapKit

class JGGServiceModel: JGGAppointmentBaseModel, MKAnnotation {
    
    override var type: AppointmentType {
        get {
            return .service
        }
    }
    
    var invitingClient: JGGClientUserModel?
    
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    
    var subtitle: String?
    
    override var name: String? {
        didSet {
            self.title = name
        }
    }
    
    override init() {
        coordinate = CLLocationCoordinate2DMake(0, 0)
    }
}
