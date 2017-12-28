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
    
    var createdBy: String?
    var createdById: String?
    var createdAt: Date?
    var modifyBy: String?
    var modifyById: String?
    var modifyAt: Date?
    var id: String!
    
    init(json: JSON) {
        super.init()
        createdBy = json["Aud_CeateBy"].string
        createdById = json["Aud_CreateByID"].string
        modifyBy = json["Aud_ModifyBy"].string
        modifyById = json["Aud_ModifyByID"].string
        id = json["ID"].stringValue
    }
    
    override init() {
        super.init()
    }
}
