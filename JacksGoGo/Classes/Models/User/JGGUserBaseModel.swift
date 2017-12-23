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
    
    override init(json: JSON) {
        super.init(json: json)
        surName         = json["Surname"].string
        givenName       = json["GivenName"].string
        gender          = json["Gender"].bool
        birthday        = json["Birthday"].string
        photoURL        = json["PhotoURL"].string
        title           = json["Title"].string
        overview        = json["Overview"].string
        rate            = json["Rate"].doubleValue
        score           = json["Score"].doubleValue
//        createdOn = json["CreatedOn"].string
//        lastLoggedOn = json["LastLoggedOn"].string
        isActive        = json["IsActive"].boolValue
        email           = json["Email"].string
        emailConfirmed  = json["EmailConfirmed"].boolValue
        phoneNumber     = json["PhoneNumber"].string
        phoneNumberVerified = json["PhoneNumberConfirmed"].boolValue
        twoFactorEnabled = json["TwoFactorEnabled"].boolValue
        accessFailedCount = json["AccessFailedCount"].intValue
        username        = json["UserName"].string

    }
}
