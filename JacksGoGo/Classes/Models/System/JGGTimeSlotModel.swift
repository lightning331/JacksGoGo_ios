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

    internal let StartOn = "StartOn"
    internal let EndOn   = "EndOn"
    internal let Peoples        = "Peoples"
    
    var startOn: Date?
    var endOn: Date?
    var peoples: Int?
    
    override init() {
        super.init()
    }
    
    init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init()
        startOn = json[StartOn].dateObject
        endOn   = json[EndOn].dateObject
        peoples = json[Peoples].int
    }
    
    func json() -> JSON {
        var json = JSON()
        json[StartOn].dateObject = startOn
        json[EndOn].dateObject   = endOn
        json[Peoples].int = peoples
        return json
    }
}
