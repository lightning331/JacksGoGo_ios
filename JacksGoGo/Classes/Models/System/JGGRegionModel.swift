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
    var countryCode: String = "+65"
    var currencyCode: String = "SGD"
    var image: String?
    var currency: JGGCurrencyModel?
    
    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        name         = json["RegionName"].stringValue
        currencyCode = json["CurrencyCode"].stringValue
        countryCode  = json["CountryCode"].stringValue
        image        = json["Image"].string
        currency     = JGGCurrencyModel(json: json["BasicCurrency"])
    }
    
    override func json() -> JSON {
        var json = super.json()
        json["RegionName"].stringValue = name
        json["CurrencyCode"].stringValue = currencyCode
        json["CountryCode"].stringValue = countryCode
        json["Image"].string = image
        if let currency = currency {
            json["BasicCurrency"] = currency.json()
        }
        return json
    }
}
