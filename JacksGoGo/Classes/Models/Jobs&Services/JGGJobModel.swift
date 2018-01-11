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

    internal let JobCategoryID = "JobCategoryID"
    internal let IsRequest = "IsRequest"
    internal let ServiceType = "ServiceType"
    internal let AttachmentURL = "AttachmentURL"
    internal let BudgetFrom = "BudgetFrom"
    internal let BudgetTo = "BudgetTo"
    internal let Budget = "Budget"
    internal let ExpiredOn = "ExpiredOn"
    internal let ReportType = "ReportType"
    internal let IsRescheduled = "IsRescheduled"
    
    var categoryId: String!
    var isRequest: Bool?
    var serviceType: Int = 0
    var attachmentUrl: [String]?
    var budgetFrom: Double?
    var budgetTo: Double?
    var budget: Double?
    var expiredOn: Date?
    var reportType: Int = 0
    var isRescheduled: Bool?
    
    override var type: AppointmentType {
        return .jobs
    }
    
    var biddingProviders: [JGGBiddingProviderModel] = []
    var invitedProviders: [JGGProviderUserModel] = []
    
    override init() {
        super.init()
    }
    
    override init(json: JSON) {
        super.init(json: json)
        categoryId = json[JobCategoryID].stringValue
        isRequest = json[IsRequest].bool
        serviceType = json[ServiceType].intValue
        attachmentUrl = json[AttachmentURL].arrayObject as? [String]
        budgetFrom = json[BudgetFrom].double
        budgetTo = json[BudgetTo].double
        budget = json[Budget].double
        expiredOn = json[ExpiredOn].dateObject
        reportType = json[ReportType].intValue
        isRescheduled = json[IsRescheduled].bool
    }
    
    override func json() -> JSON {
        var json = super.json()
        json[JobCategoryID].stringValue = categoryId
        json[IsRequest].bool = isRequest
        json[ServiceType].intValue = serviceType
        json[AttachmentURL].arrayObject = attachmentUrl
        json[BudgetFrom].double = budgetFrom
        json[BudgetTo].double = budgetTo
        json[Budget].double = budget
        json[ExpiredOn].dateObject = expiredOn
        json[ReportType].intValue = reportType
        json[IsRescheduled].bool = isRescheduled
        return json
    }
}
