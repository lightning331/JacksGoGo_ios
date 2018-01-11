//
//  JGGAddressModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGAddressModel: NSObject {

    internal let Unit = "Unit"
    internal let Floor = "Floor"
    internal let Address = "Address"
    internal let City = "City"
    internal let State = "State"
    internal let PostalCode = "PostalCode"
    internal let Latitude = "Lat"
    internal let Longitude = "Lon"
    internal let CountryCode = "CountryCode"

    var unit: String?
    var floor: String?
    var address: String?
    var city: String?
    var state: String?
    var postalCode: String?
    var lat: Double?
    var lon: Double?
    var countryCode: String?
    
    override init() {
        super.init()
    }
    
    init(json: JSON) {
        super.init()
        unit        = json[Unit].string
        floor       = json[Floor].string
        address     = json[Address].string
        city        = json[City].string
        state       = json[State].string
        postalCode  = json[PostalCode].string
        lat         = json[Latitude].double
        lon         = json[Longitude].double
        countryCode = json[CountryCode].string
    }
    
    func json() -> JSON {
        var json = JSON()
        json[Unit].string       = unit
        json[Floor].string      = floor
        json[Address].string    = address
        json[City].string       = city
        json[State].string      = state
        json[PostalCode].string = postalCode
        json[Latitude].double   = lat
        json[Longitude].double  = lon
        json[CountryCode].string = countryCode
        return json
    }
    
}
