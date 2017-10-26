//
//  JGGAppManager.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppManager: NSObject {

    static let sharedManager : JGGAppManager = {
        let instance = JGGAppManager()
        return instance
    }()
    
}
