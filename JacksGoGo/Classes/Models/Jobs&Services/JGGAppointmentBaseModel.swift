//
//  JGGAppointmentBaseModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit

public enum JGGAppointmentStatus: Int {
    case open = 0
    case closed = 1
    case confirmed = 2
}

public enum AppointmentType {
    case jobs
    case service
    case event
    case unknown
}

class JGGAppointmentBaseModel: JGGBaseModel, MKAnnotation {

    internal let Title = "Title"
    internal let Description = "Description"
    internal let Tags = "Tags"
    internal let RegionID = "RegionID"
    internal let Region = "Region"
    internal let Currency = "Currency"
    internal let CurrencyCode = "CurrencyCode"
    internal let UserProfileID = "UserProfileID"
    internal let UserProfile = "UserProfile"
    internal let PostOn = "PostOn"
    internal let Status = "Status"
    internal let Address = "Address"
    internal let DAddress = "DAddress"
    
    var title: String?
    var description_: String?
    var tags: String?
    var regionId: String!
    var region: JGGRegionModel?
    var currency: JGGCurrencyModel?
    var currencyCode: String?
    var userProfileId: String?
    var userProfile: JGGUserProfileModel?
    var postOn: Date?
    var status: JGGAppointmentStatus = .open
    var address: JGGAddressModel?
    var addressDropIn: JGGAddressModel?
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var subtitle: String?

    var type: AppointmentType {
        get {
            return .unknown
        }
    }
    
    override init() {
        super.init()
    }

    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        title           = json[Title].string
        description_    = json[Description].string
        tags            = json[Tags].string
        regionId        = json[RegionID].stringValue
        region          = JGGRegionModel(json: json[Region])
        currency        = JGGCurrencyModel(json: json[Currency])
        currencyCode    = json[CurrencyCode].string
        userProfileId   = json[UserProfileID].string
        userProfile     = JGGUserProfileModel(json: json[UserProfile])
        postOn          = json[PostOn].dateObject
        address         = JGGAddressModel(json: json[Address])
        addressDropIn   = JGGAddressModel(json: json[DAddress])
        status          = JGGAppointmentStatus(rawValue: json[Status].intValue) ?? .open
    }
    
    override func json() -> JSON {
        var json = super.json()
        json[Title].string = title
        json[Description].string = description_
        json[Tags].string = tags
        json[RegionID].stringValue = regionId
        if let region = region {
            json[Region] = region.json()
        }
        if let currency = currency {
            json[Currency] = currency.json()
        }
        json[CurrencyCode].string = currencyCode
        json[UserProfileID].string = userProfileId
        if let userProfile = userProfile {
            json[UserProfile] = userProfile.json()
        }
        json[PostOn].dateObject = postOn
        if let address = address {
            json[Address] = address.json()
        }
        if let addressDropin = addressDropIn {
            json[DAddress] = addressDropin.json()
        }
        json[Status].intValue = status.rawValue
        return json
    }
    
    func appointmentDay() -> String? {
        return postOn?.toString(format: .custom("d"))
    }
    
    func appointmentMonth() -> String? {
        return postOn?.toString(format: .custom("MMM"))
    }
    
}
