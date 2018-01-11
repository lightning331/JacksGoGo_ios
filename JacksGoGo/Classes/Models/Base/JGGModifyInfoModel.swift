//
//  JGGModifyInfoModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/10/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGModifyInfoModel: NSObject {

    var createdBy: String?
    var createdById: String?
    var createdAt: Date?
    var modifyBy: String?
    var modifyById: String?
    var modifyAt: Date?
    var isActive: Bool?
    
    init(json: JSON) {
        super.init()
        createdBy = json["CeateBy"].string
        createdById = json["CreateByID"].string
        createdAt = json["CreatedAt"].dateObject
        modifyBy = json["ModifyBy"].string
        modifyById = json["ModifyByID"].string
        modifyAt = json["ModifyAt"].dateObject
        isActive = json["IsActive"].bool
    }
}
