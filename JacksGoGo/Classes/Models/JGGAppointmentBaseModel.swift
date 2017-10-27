//
//  JGGAppointmentBaseModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 26/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

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

class JGGAppointmentBaseModel: JGGBaseModel {

    var title: String?
    var status: AppointmentStatus = .none
    var comment: String?
    var badgeNumber: Int = 0
    var appointmentDate: Date?
    
    func appointmentDay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        if let date = self.appointmentDate {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func appointmentMonth() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        if let date = self.appointmentDate {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}