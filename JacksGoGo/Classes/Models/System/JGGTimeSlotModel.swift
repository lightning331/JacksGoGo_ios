//
//  JGGTimeSlotModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGTimeSlotModel: NSObject {

    internal let SessionStartOn = "SessionStartOn"
    internal let SessionEndOn   = "SessionEndOn"
    internal let Peoples        = "Peoples"
    
    var sessionStartOn: Date?
    var sessionEndOn: Date?
    var peoples: Int?
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        super.init()
        sessionStartOn = json[SessionStartOn].dateObject
        sessionEndOn   = json[SessionEndOn].dateObject
        peoples        = json[Peoples].int
    }
    
    func json() -> JSON {
        var json = JSON()
        json[SessionStartOn].dateObject = sessionStartOn
        json[SessionEndOn].dateObject   = sessionEndOn
        json[Peoples].int = peoples
        return json
    }
}
