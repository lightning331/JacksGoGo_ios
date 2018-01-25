//
//  JGGProposalModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/25/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGProposalModel: JGGBaseModel {

    let Appointment = "Appointment"
    let Currency = "Currency"
    let UserProfile = "UserProfile"
    let AppointmentID = "AppointmentID"
    let UserProfileID = "UserProfileID"
    let Title = "Title"
    let Description = "Description"
    let BudgetFrom = "BudgetFrom"
    let BudgetTo = "BudgetTo"
    let Budget = "Budget"
    let CurrencyCode = "CurrencyCode"
    let RescheduleAllowed = "RescheduleAllowed"
    let RescheduleDate = "RescheduleDate"
    let RescheduleNote = "RescheduleNote"
    let CancellationAllowed = "CancellationAllowed"
    let CancellationDate = "CancellationDate"
    let CancellationNote = "CancellationNote"
    let IsInvited = "IsInvited"
    let SubmitOn = "SubmitOn"
    let ExpireOn = "ExpireOn"
    let Status = "Status"
    let IsViewed = "IsViewed"
    
    var appointment: JGGJobModel?
    var currency: JGGCurrencyModel?
    var userProfile: JGGUserProfileModel?
    var appointmentId: String?
    var userProfileId: String?
    var title: String?
    var description_: String?
    var budgetFrom: Double?
    var budgetTo: Double?
    var budget: Double?
    var currencyCode: String?
    var rescheduleAllowed: Bool = false
    var rescheduleDate: Date?
    var rescheduleNote: String?
    var cancellationAllowed: Bool = false
    var cancellationDate: Date?
    var cancellationNote: String?
    var isInvited: Bool = false
    var submitOn: Date?
    var expireOn: Date?
    var status: Int = 0
    var isViewed: Bool?
    
    override init() {
        super.init()
    }
    
    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        appointment         = JGGJobModel(json: json[Appointment])
        currency            = JGGCurrencyModel(json: json[Currency])
        userProfile         = JGGUserProfileModel(json: json[UserProfile])
        appointmentId       = json[AppointmentID].string
        userProfileId       = json[UserProfileID].string
        title               = json[Title].string
        description_        = json[Description].string
        budgetFrom          = json[BudgetFrom].double
        budgetTo            = json[BudgetTo].double
        budget              = json[Budget].double
        currencyCode        = json[CurrencyCode].string
        rescheduleAllowed   = json[RescheduleAllowed].boolValue
        rescheduleDate      = json[RescheduleDate].dateObject
        rescheduleNote      = json[RescheduleNote].string
        cancellationAllowed = json[CancellationAllowed].boolValue
        cancellationDate    = json[CancellationDate].dateObject
        cancellationNote    = json[CancellationNote].string
        isInvited           = json[IsInvited].boolValue
        submitOn            = json[SubmitOn].dateObject
        expireOn            = json[ExpireOn].dateObject
        status              = json[Status].intValue
        isViewed            = json[IsViewed].bool
    }
    
    override func json() -> JSON {
        var json = super.json()
        if let appointment = appointment {
            json[Appointment] = appointment.json()
        }
        if let currency = currency {
            json[Currency] = currency.json()
        }
        if let userProfile = userProfile {
            json[UserProfile] = userProfile.json()
        }
        json[AppointmentID].string  = appointmentId
        json[UserProfileID].string  = userProfileId
        json[Title].string          = title
        json[Description].string    = description_
        json[BudgetFrom].double     = budgetFrom
        json[BudgetTo].double       = budgetTo
        json[Budget].double         = budget
        json[CurrencyCode].string   = currencyCode
        json[RescheduleAllowed].boolValue = rescheduleAllowed
        json[RescheduleDate].dateObject = rescheduleDate
        json[RescheduleNote].string = rescheduleNote
        json[CancellationAllowed].boolValue = cancellationAllowed
        json[CancellationDate].dateObject = cancellationDate
        json[CancellationNote].string = cancellationNote
        json[IsInvited].boolValue   = isInvited
        json[SubmitOn].dateObject   = submitOn
        json[ExpireOn].dateObject   = expireOn
        json[Status].intValue       = status
        json[IsViewed].bool         = isViewed

        return json
    }
}
