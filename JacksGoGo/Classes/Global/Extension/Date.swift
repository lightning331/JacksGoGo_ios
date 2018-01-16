//
//  Date.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/13/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import Foundation

extension Date {
    
    /* hour should be 1 - 12, minutes should be 0 - 59 */
    init?(hour: Int, minute: Int, isAM: Bool) {
        if 0 < hour && hour <= 12 && 0 <= minute && minute < 60 {
            var hours = hour
            if hour == 12 {
                if isAM { hours = 0 }
            } else if isAM == false {
                hours = hour + 12
            }
            let timeString = String(format: "%02d:%02d", hours, minute)
            guard let date = Date(fromString: timeString, format: .custom("HH:mm")) else {
                return nil
            }
            self.init(timeInterval: 0, since: date)
        } else {
            return nil
        }
    }
    
    func timeForJacks() -> String {
        if let hour = self.component(.hour),
            let minute = self.component(.minute)
        {
            var hours = hour
            var period: String = "AM"
            if hour == 0 {
                hours = 12
            }
            else if hour == 12 {
                period = "PM"
            }
            else if hour > 12 {
                hours = hour - 12
                period = "PM"
            }
            return String(format: "%02d:%02d %@", hours, minute, period)
        } else {
            return toString(dateStyle: .none, timeStyle: .short)
        }
    }
    
    static func weekname(for number: Int) -> String? {
        let days = [
            LocalizedString("Sunday"),
            LocalizedString("Monday"),
            LocalizedString("Tuesday"),
            LocalizedString("Wednesday"),
            LocalizedString("Thursday"),
            LocalizedString("Friday"),
            LocalizedString("Saturday")
        ]
        if 0 <= number && number < days.count {
            return days[number]
        } else {
            return nil
        }
    }
}
