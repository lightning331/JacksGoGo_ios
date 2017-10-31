//
//  Double.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 31/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import Foundation

extension Double {
    
    func formattedPriceString() -> String {
        return formattedString("$ %.02f")
    }
    
    func formattedString(_ format: String = "%.02f") -> String {
        return String(format: format, self)
    }
    
}

extension Optional where Wrapped == Double {
    
    func formattedPriceString() -> String {
        return formattedString("$ %.02f")
    }
    
    func formattedString(_ format: String = "%.02f") -> String {
        guard let _self = self else {
            return String(format: format, 0.0)
        }
        return String(format: format, _self)
    }
}

extension Float {
    
    func formattedPriceString() -> String {
        return formattedString("$ %.02f")
    }
    
    func formattedString(_ format: String = "%.02f") -> String {
        return String(format: format, self)
    }
    
}

extension Optional where Wrapped == Float {
    
    func formattedPriceString() -> String {
        return formattedString("$ %.02f")
    }
    
    func formattedString(_ format: String = "%.02f") -> String {
        guard let _self = self else {
            return String(format: format, 0.0)
        }
        return String(format: format, _self)
    }
}
