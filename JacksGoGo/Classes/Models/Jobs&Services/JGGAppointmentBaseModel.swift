//
//  JGGAppointmentBaseModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

public enum AppointmentStatus {
    case none
    case pending
    case workInProgress
    case rejected
    case cancelled
    case withdrawn
    case completed
    case watingForReview
}

public enum AppointmentType {
    case jobs
    case service
    case event
    case unknown
}

class JGGAppointmentBaseModel: JGGBaseModel {

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
    
    var title: String?
    var description_: String?
    var tags: String?
    var regionId: String!
    var region: JGGRegionModel?
    var currency: JGGCurrencyModel?
    var currencyCode: String?
    var userProfileId: String!
    var userProfile: JGGUserProfileModel?
    var postOn: Date?
    var status: Int = 0
    
    var type: AppointmentType {
        get {
            return .unknown
        }
    }
    
    override init() {
        super.init()
    }

    override init(json: JSON) {
        super.init(json: json)
        title = json[Title].string
        description_ = json[Description].string
        tags = json[Tags].string
        regionId = json[RegionID].stringValue
        region = JGGRegionModel(json: json[Region])
        currency = JGGCurrencyModel(json: json[Currency])
        currencyCode = json[CurrencyCode].string
        userProfileId = json[UserProfileID].stringValue
        userProfile = JGGUserProfileModel(json: json[UserProfile])
        postOn = json[PostOn].dateObject
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
        json[UserProfileID].stringValue = userProfileId
        if let userProfile = userProfile {
            json[UserProfile] = userProfile.json()
        }
        json[PostOn].dateObject = postOn

        return json
    }
    
    func appointmentDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        if let date = self.postOn {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func appointmentMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        if let date = self.postOn {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
