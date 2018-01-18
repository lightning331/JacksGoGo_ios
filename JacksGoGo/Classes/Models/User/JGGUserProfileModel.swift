//
//  JGGUserProfileModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGUserProfileModel: JGGBaseModel {

    internal let Region = "Region"
    internal let User = "User"
    internal let RegionID = "RegionID"
    internal let UserID = "UserID"
    internal let DisplayName = "DisplayName"
    internal let LocalNo_CountryCode = "LocalNo_CountryCode"
    internal let LocalNo_AreaCode = "LocalNo_AreaCode"
    internal let LocalNo_Number = "LocalNo_Number"
    internal let LocalNo_Extension = "LocalNo_Extension"
    internal let MobileNo_CountryCode = "MobileNo_CountryCode"
    internal let MobileNo_AreaCode = "MobileNo_AreaCode"
    internal let MobileNo_Number = "MobileNo_Number"
    internal let SecurityMobileNo_CountryCode = "SecurityMobileNo_CountryCode"
    internal let SecurityMobileNo_AreaCode = "SecurityMobileNo_AreaCode"
    internal let SecurityMobileNo_Number = "SecurityMobileNo_Number"
    internal let ResidentialAddress_Unit = "ResidentialAddress_Unit"
    internal let ResidentialAddress_Floor = "ResidentialAddress_Floor"
    internal let ResidentialAddress_Address = "ResidentialAddress_Address"
    internal let ResidentialAddress_City = "ResidentialAddress_City"
    internal let ResidentialAddress_State = "ResidentialAddress_State"
    internal let ResidentialAddress_PostalCode = "ResidentialAddress_PostalCode"
    internal let ResidentialAddress_Lat = "ResidentialAddress_Lat"
    internal let ResidentialAddress_Lon = "ResidentialAddress_Lon"
    internal let ResidentialAddress_CountryCode = "ResidentialAddress_CountryCode"
    internal let BillingAddress_Unit = "BillingAddress_Unit"
    internal let BillingAddress_Floor = "BillingAddress_Floor"
    internal let BillingAddress_Address = "BillingAddress_Address"
    internal let BillingAddress_City = "BillingAddress_City"
    internal let BillingAddress_State = "BillingAddress_State"
    internal let BillingAddress_PostalCode = "BillingAddress_PostalCode"
    internal let BillingAddress_Lat = "BillingAddress_Lat"
    internal let BillingAddress_Lon = "BillingAddress_Lon"
    internal let BillingAddress_CountryCode = "BillingAddress_CountryCode"
    internal let BillingContact = "BillingContact"
    internal let BillingContractNo_CountryCode = "BillingContractNo_CountryCode"
    internal let BillingContractNo_AreaCode = "BillingContractNo_AreaCode"
    internal let BillingContractNo_Number = "BillingContractNo_Number"
    internal let BillingContractNo_Extension = "BillingContractNo_Extension"
    internal let BillingMobileNo_CountryCode = "BillingMobileNo_CountryCode"
    internal let BillingMobileNo_AreaCode = "BillingMobileNo_AreaCode"
    internal let BillingMobileNo_Number = "BillingMobileNo_Number"
    internal let BillingMobileNo_Extension = "BillingMobileNo_Extension"
    internal let IsActive = "IsActive"
    
    var region: JGGRegionModel?
    var user: JGGUserBaseModel!
    var regionId: String!
    var userId: String!
    var displayName: String?
    var localNoCountryCode: String?
    var localNoAreaCode: String?
    var localNoNumber: String?
    var localNoExtension: String?
    var mobileNoCountryCode: String?
    var mobileNoAreaCode: String?
    var mobileNoNumber : String?
    var securityMobileNoCountryCode: String?
    var securityMobileNoAreaCode : String?
    var securityMobileNoNumber: String?
    var residentialAddressUnit : String?
    var residentialAddressFloor : String?
    var residentialAddressAddress : String?
    var residentialAddressCity : String?
    var residentialAddressState : String?
    var residentialAddressPostalCode : String?
    var residentialAddressLat : String?
    var residentialAddressLon : String?
    var residentialAddressCountryCode : String?
    var billingAddressUnit : String?
    var billingAddressFloor : String?
    var billingAddressAddress : String?
    var billingAddressCity : String?
    var billingAddressState : String?
    var billingAddressPostalCode : String?
    var billingAddressLat : String?
    var billingAddressLon : String?
    var billingAddressCountryCode : String?
    var billingContact : String?
    var billingContractNoCountryCode : String?
    var billingContractNoAreaCode : String?
    var billingContractNoNumber : String?
    var billingContractNoExtension : String?
    var billingMobileNoCountryCode : String?
    var billingMobileNoAreaCode : String?
    var billingMobileNoNumber : String?
    var billingMobileNoExtension : String?
    var isActive: Bool = true

    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        region                      = JGGRegionModel(json: json[Region])
        user                        = JGGUserBaseModel(json: json[User])
        regionId                    = json[RegionID].stringValue
        userId                      = json[UserID].stringValue
        displayName                 = json[DisplayName].string
        localNoCountryCode          = json[LocalNo_CountryCode].string
        localNoAreaCode             = json[LocalNo_AreaCode].string
        localNoNumber               = json[LocalNo_Number].string
        localNoExtension            = json[LocalNo_Extension].string
        mobileNoCountryCode         = json[MobileNo_CountryCode].string
        mobileNoAreaCode            = json[MobileNo_AreaCode].string
        mobileNoNumber              = json[MobileNo_Number].string
        securityMobileNoCountryCode = json[SecurityMobileNo_CountryCode].string
        securityMobileNoAreaCode    = json[SecurityMobileNo_AreaCode].string
        securityMobileNoNumber      = json[SecurityMobileNo_Number].string
        residentialAddressUnit      = json[ResidentialAddress_Unit].string
        residentialAddressFloor     = json[ResidentialAddress_Floor].string
        residentialAddressAddress   = json[ResidentialAddress_Address].string
        residentialAddressCity      = json[ResidentialAddress_City].string
        residentialAddressState     = json[ResidentialAddress_State].string
        residentialAddressPostalCode = json[ResidentialAddress_PostalCode].string
        residentialAddressLat       = json[ResidentialAddress_Lat].string
        residentialAddressLon       = json[ResidentialAddress_Lon].string
        residentialAddressCountryCode = json[ResidentialAddress_CountryCode].string
        billingAddressUnit          = json[BillingAddress_Unit].string
        billingAddressFloor         = json[BillingAddress_Floor].string
        billingAddressAddress       = json[BillingAddress_Address].string
        billingAddressCity          = json[BillingAddress_City].string
        billingAddressState         = json[BillingAddress_State].string
        billingAddressPostalCode    = json[BillingAddress_PostalCode].string
        billingAddressLat           = json[BillingAddress_Lat].string
        billingAddressLon           = json[BillingAddress_Lon].string
        billingAddressCountryCode   = json[BillingAddress_CountryCode].string
        billingContact              = json[BillingContact].string
        billingContractNoCountryCode = json[BillingContractNo_CountryCode].string
        billingContractNoAreaCode   = json[BillingContractNo_AreaCode].string
        billingContractNoNumber     = json[BillingContractNo_Number].string
        billingContractNoExtension  = json[BillingContractNo_Extension].string
        billingMobileNoCountryCode  = json[BillingMobileNo_CountryCode].string
        billingMobileNoAreaCode     = json[BillingMobileNo_AreaCode].string
        billingMobileNoNumber       = json[BillingMobileNo_Number].string
        billingMobileNoExtension    = json[BillingMobileNo_Extension].string
        isActive                    = json[IsActive].boolValue
    }
    
    override func json() -> JSON {
        var json = super.json()
        if let region = region {
            json[Region] = region.json()
        }
        if let user = user {
            json[User] = user.json()
        }
        json[RegionID].stringValue                  = regionId
        json[UserID].stringValue                    = userId
        json[DisplayName].string                    = displayName
        json[LocalNo_CountryCode].string            = localNoCountryCode
        json[LocalNo_AreaCode].string               = localNoAreaCode
        json[LocalNo_Number].string                 = localNoNumber
        json[LocalNo_Extension].string              = localNoExtension
        json[MobileNo_CountryCode].string           = mobileNoCountryCode
        json[MobileNo_AreaCode].string              = mobileNoAreaCode
        json[MobileNo_Number].string                = mobileNoNumber
        json[SecurityMobileNo_CountryCode].string   = securityMobileNoCountryCode
        json[SecurityMobileNo_AreaCode].string      = securityMobileNoAreaCode
        json[SecurityMobileNo_Number].string        = securityMobileNoNumber
        json[ResidentialAddress_Unit].string        = residentialAddressUnit
        json[ResidentialAddress_Floor].string       = residentialAddressFloor
        json[ResidentialAddress_Address].string     = residentialAddressAddress
        json[ResidentialAddress_City].string        = residentialAddressCity
        json[ResidentialAddress_State].string       = residentialAddressState
        json[ResidentialAddress_PostalCode].string  = residentialAddressPostalCode
        json[ResidentialAddress_Lat].string         = residentialAddressLat
        json[ResidentialAddress_Lon].string         = residentialAddressLon
        json[ResidentialAddress_CountryCode].string = residentialAddressCountryCode
        json[BillingAddress_Unit].string            = billingAddressUnit
        json[BillingAddress_Floor].string           = billingAddressFloor
        json[BillingAddress_Address].string         = billingAddressAddress
        json[BillingAddress_City].string            = billingAddressCity
        json[BillingAddress_State].string           = billingAddressState
        json[BillingAddress_PostalCode].string      = billingAddressPostalCode
        json[BillingAddress_Lat].string             = billingAddressLat
        json[BillingAddress_Lon].string             = billingAddressLon
        json[BillingAddress_CountryCode].string     = billingAddressCountryCode
        json[BillingContact].string                 = billingContact
        json[BillingContractNo_CountryCode].string  = billingContractNoCountryCode
        json[BillingContractNo_AreaCode].string     = billingContractNoAreaCode
        json[BillingContractNo_Number].string       = billingContractNoNumber
        json[BillingContractNo_Extension].string    = billingContractNoExtension
        json[BillingMobileNo_CountryCode].string    = billingMobileNoCountryCode
        json[BillingMobileNo_AreaCode].string       = billingMobileNoAreaCode
        json[BillingMobileNo_Number].string         = billingMobileNoNumber
        json[BillingMobileNo_Extension].string      = billingMobileNoExtension
        json[IsActive].boolValue                    = isActive
        return json
    }
}
