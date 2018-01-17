//
//  JGGUserBaseModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 31/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGUserBaseModel: JGGBaseModel {
    
    internal let Surname         = "Surname"
    internal let GivenName       = "GivenName"
    internal let Gender          = "Gender"
    internal let Birthday        = "Birthday"
    internal let PhotoURL        = "PhotoURL"
    internal let Title           = "Title"
    internal let Overview        = "Overview"
    internal let Rate            = "Rate"
    internal let Score           = "Score"
    internal let CreatedOn       = "CreatedOn"
    internal let LastLoggedOn    = "LastLoggedOn"
    internal let IsActive        = "IsActive"
    internal let Email           = "Email"
    internal let EmailConfirmed  = "EmailConfirmed"
    internal let PhoneNumber     = "PhoneNumber"
    internal let PhoneNumberConfirmed = "PhoneNumberConfirmed"
    internal let TwoFactorEnabled = "TwoFactorEnabled"
    internal let LockoutEndDateUtc = "LockoutEndDateUtc"
    internal let LockoutEnabled  = "LockoutEnabled"
    internal let AccessFailedCount = "AccessFailedCount"
    internal let UserName        = "UserName"

    var surName: String?
    var givenName: String?
    var gender: Bool?  // true: Male, false: Female
    var birthday: String?
    var photoURL: String?
    var title: String?
    var overview: String?
    var rate: Double = 0
    var score: Double = 0
    var createdOn: Date?
    var lastLoggedOn: Date?
    var isActive: Bool = false
    var email: String!
    var emailConfirmed: Bool = false
    var phoneNumber: String?
    var phoneNumberVerified: Bool = false
    var twoFactorEnabled: Bool = false
    var accessFailedCount: Int = 0
    var username: String!
    
    var fullname: String? {
        get {
            if surName == nil && givenName == nil {
                return nil
            }
            return String(format: "%@ %@", surName ?? "", givenName ?? "")
        }
        set {
            surName = newValue
        }
    }
    
    var genderName: String? {
        if let gender = gender {
            return gender ? "male" : "female"
        } else {
            return nil
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
        surName             = json[Surname].string
        givenName           = json[GivenName].string
        gender              = json[Gender].bool
        birthday            = json[Birthday].string
        photoURL            = json[PhotoURL].string
        title               = json[Title].string
        overview            = json[Overview].string
        rate                = json[Rate].doubleValue
        score               = json[Score].doubleValue
        createdOn           = json[CreatedOn].dateObject
        lastLoggedOn        = json[LastLoggedOn].dateObject
        isActive            = json[IsActive].boolValue
        email               = json[Email].string
        emailConfirmed      = json[EmailConfirmed].boolValue
        phoneNumber         = json[PhoneNumber].string
        phoneNumberVerified = json[PhoneNumberConfirmed].boolValue
        twoFactorEnabled    = json[TwoFactorEnabled].boolValue
        accessFailedCount   = json[AccessFailedCount].intValue
        username            = json[UserName].string

    }
    
    override func json() -> JSON {
        var json = super.json()
        json[Surname].string                = surName
        json[GivenName].string              = givenName
        json[Gender].bool                   = gender
        json[Birthday].string               = birthday
        json[PhotoURL].string               = photoURL
        json[Title].string                  = title
        json[Overview].string               = overview
        json[Rate].doubleValue              = rate
        json[Score].doubleValue             = score
        json[CreatedOn].dateObject          = createdOn
        json[LastLoggedOn].dateObject       = lastLoggedOn
        json[IsActive].boolValue            = isActive
        json[Email].string                  = email
        json[EmailConfirmed].boolValue      = emailConfirmed
        json[PhoneNumber].string            = phoneNumber
        json[PhoneNumberConfirmed].boolValue = phoneNumberVerified
        json[TwoFactorEnabled].boolValue    = twoFactorEnabled
        json[AccessFailedCount].intValue    = accessFailedCount
        json[UserName].string               = username
        return json
    }
}

