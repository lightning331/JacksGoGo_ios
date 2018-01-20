//
//  JSON.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    public var dateObject: Date? {
        get {
            switch self.type {
            case .string:
                let dateString = self.stringValue.prefix(19)
                return DateFormatter.defaultFormatter.date(from: String(dateString))
            default:
                return nil
            }
        }
        set {
            if let newValue = newValue {
                self.object = DateFormatter.defaultFormatter.string(from: newValue)
            } else {
                self.object = NSNull()
            }
        }
    }
}
