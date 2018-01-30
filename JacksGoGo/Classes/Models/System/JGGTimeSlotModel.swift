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
    internal let Peoples = "Peoples"
    internal let IsSpecific = "IsSpecific"
    
    var startOn: Date?
    var endOn: Date?
    var peoples: Int?
    var isSpecific: Bool?
    
    override init() {
        super.init()
    }
    
    init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        guard let startOn = json[StartOn].dateObject else {
            return nil
        }
        super.init()
        self.startOn = startOn
        endOn   = json[EndOn].dateObject
        peoples = json[Peoples].int
        isSpecific = json[IsSpecific].bool
    }
    
    init(startOn: Date?, endOn: Date?, people: Int?, isSpecific: Bool?) {
        super.init()
        self.startOn = startOn
        self.endOn = endOn
        self.peoples = people
        self.isSpecific = isSpecific
    }
    
    func json() -> JSON {
        var json = JSON()
        json[StartOn].dateObject = startOn
        json[EndOn].dateObject   = endOn
        json[Peoples].int = peoples
        json[IsSpecific].bool = isSpecific
        return json
    }
}
