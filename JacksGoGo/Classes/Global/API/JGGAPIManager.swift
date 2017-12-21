//
//  JGGAPIManager.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAPIManager: NSObject {

    static let sharedManager : JGGAPIManager = {
        let instance = JGGAPIManager()
        return instance
    }()

    
}
