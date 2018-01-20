//
//  JGGServiceModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class JGGServiceModel: JGGAppointmentBaseModel {
    
    override var type: AppointmentType {
        get {
            return .service
        }
    }
    
    var invitingClient: JGGClientUserModel?
    
    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        
    }
    
    override init() {
        super.init()
    }
}
