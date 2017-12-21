//
//  Global.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 31/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum BiddingStatus: String {
    case pending = "pending"
    case accepted = "accepted"
    case rejected = "rejected"
    case declined = "declined"
    case notResponded = "notResponded"
}

public func LocalizedString(_ key: String, comment: String = "") -> String {
    return NSLocalizedString(key, comment: comment)
}

public func DateString(from date: Date, format: String = "d MMM, yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

public func DateTimeString(from date: Date, format: String = "d MMM, yyyy h:mm a") -> String {
    return DateString(from: date, format: format)
}

typealias Dictionary = [String: Any]

typealias DefaultResponse = (JSON?, Error?) -> Void
