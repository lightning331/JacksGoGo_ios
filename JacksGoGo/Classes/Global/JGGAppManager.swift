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
    
    var currentUser: JGGUserProfileModel?
    
    var categories: [JGGCategoryModel] = []
    
    var regions: [JGGRegionModel] = []
    
    var currentRegion : JGGRegionModel? {
        get {
            let userDefaults = UserDefaults.standard
            if let regionId = userDefaults.string(forKey: "region") {
                return regions.filter { $0.id == regionId }.first
            } else {
                return regions.first
            }
        }
        set {
            let userDefaults = UserDefaults.standard
            if let newRegion = newValue {
                userDefaults.set(newRegion.id, forKey: "region")
            } else {
                userDefaults.removeObject(forKey: "region")
            }
            userDefaults.synchronize()
        }
    }
    
    var isAuthorized: Bool {
        return JGGAPIManager.sharedManager.getToken() != nil
    }
    
    private let USERNAME_KEY = "username"
    private let PASSWORD_KEY = "password"
    
    func save(username: String, password: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(username, forKey: USERNAME_KEY)
        userDefaults.set(password, forKey: PASSWORD_KEY)
        userDefaults.synchronize()
    }
    
    func getUsernamePassword() -> (String?, String?) {
        let userDefaults = UserDefaults.standard
        return (userDefaults.string(forKey: USERNAME_KEY), userDefaults.string(forKey: PASSWORD_KEY))
    }
    
    func clearCreditional() -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: USERNAME_KEY)
        userDefaults.set(nil, forKey: PASSWORD_KEY)
        userDefaults.synchronize()
    }
}
