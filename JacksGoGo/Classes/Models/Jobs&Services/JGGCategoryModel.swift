//
//  JGGCategoryModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class JGGCategoryModel: JGGBaseModel {

    var code: String?
    var name: String?
    var image: String?
    var isQuickJob: Bool = false
    
    override init() {
        super.init()
    }
    
    override init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        super.init(json: json)
        code = json["Code"].string
        name = json["Name"].string
        image = json["Image"].string
    }
    
    override func json() -> JSON {
        var json = super.json()
        json["Code"].string = code
        json["Name"].string = name
        json["Image"].string = image
        return json
    }
    
    func imageURL() -> URL? {
        if let urlString = image {
            let url = URL(string: urlString)
            return url
        } else {
            return nil
        }
    }
}
