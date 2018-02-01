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
    internal let ServiceType    = "ServiceType"
    internal let AttachmentURL  = "AttachmentURLs"
    internal let BudgetFrom     = "BudgetFrom"
    internal let BudgetTo       = "BudgetTo"
    internal let Budget         = "Budget"
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
    var serviceType: Int = 0
    var attachmentUrl: [String]?
    var budgetFrom: Double?
    var budgetTo: Double?
    var budget: Double?
    var expiredOn: Date?
    var reportType: Int = 0
    var isRescheduled: Bool?
    var jobType: JGGJobType = .none
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
        serviceType = json[ServiceType].intValue
        attachmentUrl = json[AttachmentURL].arrayObject as? [String]
        budgetFrom = json[BudgetFrom].double
        budgetTo = json[BudgetTo].double
        budget = json[Budget].double
        expiredOn = json[ExpiredOn].dateObject
        reportType = json[ReportType].intValue
        isRescheduled = json[IsRescheduled].bool
        jobType = JGGJobType(rawValue: json[JobType].intValue) ?? .none
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
        json[ServiceType].intValue = serviceType
        json[AttachmentURL].arrayObject = attachmentUrl
        json[BudgetFrom].double = budgetFrom
        json[BudgetTo].double = budgetTo
        json[Budget].double = budget
        json[ExpiredOn].dateObject = expiredOn
        json[ReportType].intValue = reportType
        json[IsRescheduled].bool = isRescheduled
        json[JobType].intValue = jobType.rawValue
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
}
