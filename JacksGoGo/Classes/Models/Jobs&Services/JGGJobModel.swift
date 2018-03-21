//
//  JGGJobModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGJobModel: JGGAppointmentBaseModel {

    internal let CategoryID     = "CategoryID"
    internal let Category       = "Category"
    internal let IsRequest      = "IsRequest"
    internal let AppointmentType = "AppointmentType"
    internal let AttachmentURL  = "AttachmentURLs"
    internal let BudgetFrom     = "BudgetFrom"
    internal let BudgetTo       = "BudgetTo"
    internal let Budget         = "Budget"
    internal let BudgetType     = "BudgetType"
    internal let ExpiredOn      = "ExpiredOn"
    internal let ReportType     = "ReportType"
    internal let IsRescheduled  = "IsRescheduled"
    internal let JobType        = "JobType"
    internal let RepetitionType = "RepetitionType"
    internal let Repetition     = "Repetition"
    internal let IsQuickJob     = "IsQuickJob"
    internal let ViewCount      = "ViewCount"
    internal let Sessions       = "Sessions"
    
    var categoryId: String!
    var category: JGGCategoryModel?
    var isRequest: Bool = true
    var appointmentType: Int = 0  // 0: Repetation, 1: One-time
    var attachmentUrl: [String]?
    var budgetFrom: Double?
    var budgetTo: Double?
    var budget: Double?
    var budgetType: Int = 0  // 0: Non-select, 1: No limit, 2: Fixed, 3: Package
    var expiredOn: Date?
    var reportType: Int = 0
    var isRescheduled: Bool?
    var repetitionType: JGGRepetitionType?
    var repetition: String?
    var isQuickJob: Bool = false
    var sessions: [JGGTimeSlotModel]?
    var viewCount: Int = 0
    var proposal: JGGProposalModel?
    var attachmentImages: [UIImage]?
    
    override var type: AppointmentType {
        return .jobs
    }
    
    var biddingProviders: [JGGBiddingProviderModel] = []
    var invitedProviders: [JGGProviderUserModel] = []
    
    override init() {
        super.init()
    }
    
    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        categoryId = json[CategoryID].stringValue
        category = JGGCategoryModel(json: json[Category])
        isRequest = json[IsRequest].boolValue
        appointmentType = json[AppointmentType].intValue
        attachmentUrl = json[AttachmentURL].arrayObject as? [String]
        budgetFrom = json[BudgetFrom].double
        budgetTo = json[BudgetTo].double
        budget = json[Budget].double
        budgetType = json[BudgetType].intValue
        expiredOn = json[ExpiredOn].dateObject
        reportType = json[ReportType].intValue
        isRescheduled = json[IsRescheduled].bool
        if let value = json[RepetitionType].int {
            repetitionType = JGGRepetitionType(rawValue: value) ?? .none
        }
        repetition = json[Repetition].string
        isQuickJob = json[IsQuickJob].boolValue
        if let jsonSessions = json[Sessions].array {
            sessions = []
            for jsonSession in jsonSessions {
                if let timeSlot = JGGTimeSlotModel(json: jsonSession) {
                    sessions!.append(timeSlot)
                }
            }
        }
        
        viewCount = json[ViewCount].intValue
    }
    
    override func json() -> JSON {
        var json = super.json()
        json[CategoryID].stringValue = categoryId
        if let category = category {
            json[Category] = category.json()
        }
        json[IsRequest].boolValue = isRequest
        json[appointmentType].intValue = appointmentType
        json[AttachmentURL].arrayObject = attachmentUrl
        json[BudgetFrom].double = budgetFrom
        json[BudgetTo].double = budgetTo
        json[Budget].double = budget
        json[BudgetType].intValue = budgetType
        json[ExpiredOn].dateObject = expiredOn
        json[ReportType].intValue = reportType
        json[IsRescheduled].bool = isRescheduled
        json[RepetitionType].int = repetitionType?.rawValue
        json[Repetition].string = repetition
        json[IsQuickJob].boolValue = isQuickJob
        if let sessions = sessions {
            var jsonSessions: [JSON] = []
            for timeSlot in sessions {
                jsonSessions.append(timeSlot.json())
            }
            json[Sessions].arrayObject = jsonSessions
        }
        json[ViewCount].intValue = viewCount
        return json
    }
    
    var reportTypeName: String? {
        switch reportType {
        case 1:
            return LocalizedString("Before & After Photo")
        case 2:
            return LocalizedString("Geotracking")
        case 3:
            return LocalizedString("Before & After Photo") + ", " + LocalizedString("Geotracking")
        case 4:
            return LocalizedString("PIN Code")
        case 5:
            return LocalizedString("Before & After Photo") + ", " + LocalizedString("PIN Code")
        case 6:
            return LocalizedString("Geotracking") + ", " + LocalizedString("PIN Code")
        case 7:
            return LocalizedString("Before & After Photo") + ", " + LocalizedString("Geotracking") + ", " + LocalizedString("PIN Code")
        default:
            return LocalizedString("No set")
        }
    }
    
    override func clone() -> JGGJobModel? {
        let clone = JGGJobModel(json: self.json())
        return clone
    }
    
    func jobTimeDescription() -> String {
        var timeString: String = ""
        
        if let jobTime = sessions?.first {
            let startTime = jobTime.startOn
            if jobTime.isSpecific == true {
                timeString = "on "
            } else {
                timeString = "any time until "
            }
            timeString += ((startTime?.toString(format: .custom("d MMM, yyyy")).uppercased() ?? "") + " " + (startTime?.timeForJacks() ?? ""))
            if let endTime = jobTime.endOn {
                timeString += (" - " + endTime.timeForJacks())
            }
        }
        else if repetitionType != nil {
            if repetitionType == .weekly {
                let days = repetition!
                    .split(separator: ",")
                    .flatMap { weekNames[Int($0)!] }
                    .joined(separator: ", ")
                timeString = String(format: "Every %@ of the week", days)
            } else if repetitionType == .monthly {
                let days = repetition!
                    .split(separator: ",")
                    .flatMap { dayNames[Int($0)! - 1] }
                    .joined(separator: ", ")
                timeString = String(format: "Every %@ of the month", days)
            }
        } else {
            timeString = "Not set"
        }
        return timeString
    }

    func budgetDescription() -> String {
        var desc: String = ""
        if budgetType == 0 {
            desc = LocalizedString("Not set")
        }
        else if budgetType == 1 {
            desc = LocalizedString("No limit")
        }
        else if budgetType == 2 {
            desc = String(format: "%@\n$ %.2f", LocalizedString("Fixed"), budget ?? 0)
        }
        else if budgetType == 3 {
            desc = String(format: "%@\n$ %.2f - $ %.2f/month", LocalizedString("Package"), budgetFrom ?? 0, budgetTo ?? 0)
        }
        return desc
    }
    
    func budgetSimpleDescription() -> String {
        var desc: String = ""
        if budgetType == 0 {
            desc = LocalizedString("Not set")
        }
        else if budgetType == 1 {
            desc = LocalizedString("No limit")
        }
        else if budgetType == 2 {
            desc = String(format: "$ %.2f", budget ?? 0)
        }
        else if budgetType == 3 {
            desc = String(format: "$ %.2f - $ %.2f", budgetFrom ?? 0, budgetTo ?? 0)
        }
        return desc
    }
}
