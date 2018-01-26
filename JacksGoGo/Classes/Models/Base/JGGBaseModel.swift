//
//  JGGBaseModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGBaseModel: NSObject {
    
//    var aud: JGGModifyInfoModel?
    var id: String?
    
    init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init()
//        aud = JGGModifyInfoModel(json: json["Aud"])
        id = json["ID"].string
    }
    
    override init() {
        super.init()
    }
    
    func json() -> JSON {
        var json = JSON()
        json["ID"].string = id
        return json
    }
    
    func clone() -> JGGBaseModel? {
        let clone = JGGBaseModel(json: self.json())
        return clone
    }
}
