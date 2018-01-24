//
//  Global.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 31/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import Foundation
import SwiftyJSON
import AFDateHelper
import Crashlytics

// MARK: - Option

public let SHOW_TEMP_DATA: Bool = false

// Public constants

public enum BiddingStatus: String {
    case pending = "pending"
    case accepted = "accepted"
    case rejected = "rejected"
    case declined = "declined"
    case notResponded = "notResponded"
}

func CLS_LOG_SWIFT(format: String = "", _ args: [CVarArg] = [], file: String = #file, function: String = #function, line: Int = #line)
{
    let filename = URL(string: file)?.lastPathComponent.components(separatedBy: ".").first

    #if DEBUG
        CLSNSLogv("\(String(describing: filename)).\(function) line \(line) $ \(format)", getVaList(args))
    #else
        CLSLogv("\(String(describing: filename)).\(function) line \(line) $ \(format)", getVaList(args))
    #endif
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

func solidButton(_ button: UIButton,
                 enable: Bool,
                 enableColor: UIColor = UIColor.JGGOrange,
                 enableTextColor: UIColor = UIColor.JGGWhite,
                 disableColor: UIColor = UIColor.JGGGrey3,
                 disableTextColor: UIColor = UIColor.JGGWhite
    )
{
    button.isEnabled = enable
    if enable {
        button.backgroundColor = enableColor
        button.setTitleColor(enableTextColor, for: .normal)
    } else {
        button.backgroundColor = disableColor
        button.setTitleColor(disableTextColor, for: .normal)
    }
}

func categoryCellSize(for viewWidth: CGFloat, margin: CGFloat) -> CGSize {
    var w: CGFloat = 0
    if viewWidth <= 375 {
        w = (viewWidth - margin * 2) / 3 - 1
    } else {
        w = (viewWidth - margin * 3) / 4 - 1
    }
    let h = w * 1.16667
    return CGSize(width: w, height: h)
}

public let DateOnly: DateFormatType = .custom("yyyy-MM-dd")
public let TimeOnly: DateFormatType = .custom("HH:mm:ss")
public let FullDate: DateFormatType = .custom("yyyy-MM-dd'T'HH:mm:ss")

public enum JGGColorSchema {
    case red
    case green
    case cyan
    case orange
    case purple
}

typealias Dictionary = [String: Any]

typealias DefaultResponse = (JSON?, Error?) -> Void
typealias BoolStringClosure = (Bool, String?) -> Void
typealias UserModelResponse = (JGGUserBaseModel?, String?) -> Void
typealias UserProfileModelResponse = (JGGUserProfileModel?, String?) -> Void
typealias RegionListClosure = ([JGGRegionModel]) -> Void
typealias CategoryListClosure = ([JGGCategoryModel]) -> Void
typealias StringStringClosure = (String?, String?) -> Void
typealias ProgressClosure = (Float) -> Void
typealias VoidClosure = () -> Void
typealias AppointmentsClosure = ([JGGJobModel]) -> Void

public var weekNames: [String] = [
    LocalizedString("Sunday"),
    LocalizedString("Monday"),
    LocalizedString("Tuesday"),
    LocalizedString("Wednesday"),
    LocalizedString("Thursday"),
    LocalizedString("Friday"),
    LocalizedString("Saturday")
]

public var dayNames: [String] = [
    "1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th",
    "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th",
    "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st",
]

public let JGGNotificationShowToday: String = "com.jacksgogo.shotToday"
public let JGGNotificationLoggedIn: String  = "com.jacksgogo.loggedin"
public let JGGNotificationLoggedOut: String  = "com.jacksgogo.loggedout"
