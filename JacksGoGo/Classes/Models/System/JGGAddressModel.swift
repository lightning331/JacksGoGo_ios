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
    internal let IsDrop = "IsDrop"

    var unit: String?
    var floor: String?
    var address: String?
    var city: String?
    var state: String?
    var postalCode: String?
    var lat: Double?
    var lon: Double?
    var countryCode: String?
    var isDontShowFullAddress: Bool = false
    
    override init() {
        super.init()
    }
    
    init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
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
        isDontShowFullAddress = json[IsDrop].boolValue
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
        json[IsDrop].boolValue = isDontShowFullAddress
        return json
    }
    
    var fullName: String {
        var fullName: String = ""
        if let unit = unit {
            fullName += unit + " "
        }
        if let floor = floor {
            fullName += floor + " "
        }
        if let address = address {
            fullName += address + ", "
        }
        if let city = city {
            fullName += city + ", "
        }
        if let state = state {
            fullName += state + ", "
        }
        if let postalCode = postalCode {
            fullName += postalCode
        }
        return fullName
    }
    
}
