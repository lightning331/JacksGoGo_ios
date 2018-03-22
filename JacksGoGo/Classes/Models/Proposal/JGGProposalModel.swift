//
//  JGGProposalModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/25/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

public enum JGGProposalStatus: Int {
    case open = 0
    case rejected = 1
    case confirmed = 2
    case withdrawed = 3
}

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
    let Breakdown = "Breakdown"
    let CurrencyCode = "CurrencyCode"
    let RescheduleAllowed = "RescheduleAllowed"
    let RescheduleTime = "RescheduleTime"
    let RescheduleNote = "RescheduleNote"
    let CancellationAllowed = "CancellationAllowed"
    let CancellationTime = "CancellationTime"
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
    var breakdown: String?
    var currencyCode: String?
    var rescheduleAllowed: Bool?
    var rescheduleDate: Date?
    var rescheduleNote: String?
    var cancellationAllowed: Bool?
    var cancellationDate: Date?
    var cancellationNote: String?
    var isInvited: Bool = false
    var submitOn: Date?
    var expireOn: Date?
    var status: JGGProposalStatus = .open
    var isViewed: Bool?
    var rescheduleTime: Double?
    var cancellationTime: Double?
    
    override init() {
        super.init()
    }
    
    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
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
        json[Breakdown].string      = breakdown
        json[CurrencyCode].string   = currencyCode
        json[RescheduleAllowed].bool = rescheduleAllowed
        json[RescheduleNote].string = rescheduleNote
        json[CancellationAllowed].bool = cancellationAllowed
        json[CancellationNote].string = cancellationNote
        json[IsInvited].boolValue   = isInvited
        json[SubmitOn].dateObject   = submitOn
        json[ExpireOn].dateObject   = expireOn
        json[Status].intValue       = status.rawValue
        json[IsViewed].bool         = isViewed
        json[RescheduleTime].double = rescheduleTime
        json[CancellationTime].double = cancellationTime

        return json
    }
    
    override func clone() -> JGGProposalModel? {
        let clone = JGGProposalModel(json: self.json())
        return clone
    }

    override func update(with json: JSON) {
        super.update(with: json)
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
        breakdown           = json[Breakdown].string
        currencyCode        = json[CurrencyCode].string
        rescheduleAllowed   = json[RescheduleAllowed].bool
        rescheduleNote      = json[RescheduleNote].string
        cancellationAllowed = json[CancellationAllowed].bool
        cancellationNote    = json[CancellationNote].string
        isInvited           = json[IsInvited].boolValue
        submitOn            = json[SubmitOn].dateObject
        expireOn            = json[ExpireOn].dateObject
        status              = JGGProposalStatus(rawValue: json[Status].intValue) ?? .open
        isViewed            = json[IsViewed].bool
        rescheduleTime      = json[RescheduleTime].double
        cancellationTime    = json[CancellationTime].double
    }
    
    func rescheduleTimeDescription() -> String? {
        return timeDescription(allow: rescheduleAllowed, timeValue: rescheduleTime)
    }
    
    func cancellationTimeDescription() -> String? {
        return timeDescription(allow: cancellationAllowed, timeValue: cancellationTime)
    }
    
    private func timeDescription(allow: Bool?, timeValue: Double?) -> String? {
        if allow == true {
            let totalTime = timeValue ?? 0
            let days: Int = Int(totalTime / (3600 * 24))
            let hours: Int = Int((totalTime - Double(days) * 3600 * 24) / 3600)
            let minutes: Int = Int((totalTime - Double(days) * 3600 * 24 - Double(hours) * 3600) / 60)
            var result: String = ""
            if days > 0 {
                if days == 1 {
                    result = "1 day "
                } else {
                    result = String(format: "%d days ", days)
                }
            }
            if hours > 0 {
                if hours == 1 {
                    result = result + "1 hour "
                } else {
                    result = result + String(format: "%d hours ", hours)
                }
            }
            if minutes > 0 {
                if minutes == 1 {
                    result = result + "1 minute "
                } else {
                    result = result + String(format: "%d minutes ", minutes)
                }
            }
            result = String(format: "At least %@ before.", result)
            return result
        } else {
            return LocalizedString("Not allowed")
        }
    }
    
    func budgetDescription() -> String {
        if let budget = budget {
            return String(format: "$ %.2f", budget)
        } else if let budgetFrom = budgetFrom, let budgetTo = budgetTo {
            return String(format: "$ %.2f - $ %.2f", budgetFrom, budgetTo)
        } else {
            return "Not set"
        }
    }
}
