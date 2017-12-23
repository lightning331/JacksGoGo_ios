//
//  JGGRegionModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/23/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGRegionModel: JGGBaseModel {

    var name: String = "Singapore"
    var countryCode: String = "SG"
    var currencyCode: String = "SGD"
    
    override init(json: JSON) {
        super.init(json: json)
        name = json["RegionName"].stringValue
        currencyCode = json["CurrencyCode"].stringValue
        countryCode = json["CountryCode"].stringValue
    }
}
