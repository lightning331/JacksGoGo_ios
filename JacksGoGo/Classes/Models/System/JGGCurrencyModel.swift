//
//  JGGCurrencyModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGCurrencyModel: JGGBaseModel {

    internal let CurrencyCode = "CurrencyCode"
    internal let CurrencyName = "CurrencyName"
    internal let Symbol = "Symbol"
    
    var currencyCode: String?
    var currencyName: String?
    var symbol: String?
    
    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        currencyCode = json[CurrencyCode].string
        currencyName = json[CurrencyName].string
        symbol = json[Symbol].string
    }
    
    override func json() -> JSON {
        var json = super.json()
        json[CurrencyCode].string = currencyCode
        json[CurrencyName].string = currencyName
        json[Symbol].string = symbol
        return json
    }
}
