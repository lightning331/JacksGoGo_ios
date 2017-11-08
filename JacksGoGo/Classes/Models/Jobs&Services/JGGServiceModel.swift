//
//  JGGServiceModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGServiceModel: JGGAppointmentBaseModel {

    override var type: AppointmentType {
        get {
            return .service
        }
    }
}
