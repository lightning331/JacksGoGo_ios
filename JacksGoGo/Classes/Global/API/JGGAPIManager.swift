//
//  JGGAPIManager.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import SwiftyJSON

class JGGAPIManager: NSObject {

    private let HEADER_AUTHORIZATION         = "Authorization"
    private let HEADER_VALUE_PREFIX          = "Bearer"

    var token: String?
    
    static let sharedManager : JGGAPIManager = {
        let instance = JGGAPIManager()
        return instance
    }()

    override init() {
        super.init()
        
    }
    
    // MARK: - Base request
    
    func request(url: String,
                 method: HTTPMethod,
                 params: Dictionary?,
                 encoding: ParameterEncoding = JSONEncoding.default,
                 hasHeader: Bool = true) -> DataRequest
    {
        var header: [String: String]?
        if let token = self.token, hasHeader == true {
            header = [
                HEADER_AUTHORIZATION : HEADER_VALUE_PREFIX + " " + token,
            ]
        }
        return Alamofire.request(url,
                                 method: method,
                                 parameters: params,
                                 encoding: encoding,
                                 headers: header)
    }
    
    /**
     *  POST request
     */
    func POST(url: String,
              body: Dictionary?,
              hasHeader: Bool = true,
              complete: @escaping DefaultResponse) -> Void
    {
        request(url: url, method: .post, params: body, encoding: JSONEncoding.default,
                hasHeader: true).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                let result = JSON(data)
                complete(result, nil)
                break
            case .failure(let error):
                complete(nil, error)
                break
            }
        }
    }
    
    /**
     *  GET request
     */
    func GET(url: String,
             params: Dictionary?,
             hasHeader: Bool = true,
             complete: @escaping DefaultResponse) -> Void
    {
        request(url: url, method: .get, params: params, encoding: URLEncoding.default,
                hasHeader: true).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                let result = JSON(data)
                complete(result, nil)
                break
            case .failure(let error):
                complete(nil, error)
                break
            }
        }
    }
    
    /**
     *  DELETE request
     */
    func DELETE(url: String,
                params: Dictionary?,
                body: Dictionary?,
                hasHeader: Bool = true,
                complete: @escaping DefaultResponse) -> Void
    {
        var fullUrl: String = url
        if let params = params {
            fullUrl += "?"
            for (key, value) in params {
                var strVal: String = ""
                if let val = value as? String {
                    strVal = val
                } else if let val = value as? Int {
                    strVal = String(val)
                } else if let val = value as? Double {
                    strVal = String(val)
                } else if let val = value as? Float {
                    strVal = String(val)
                }
                fullUrl += String(format: "%@=%@", key, strVal)
            }
        }
        request(url: fullUrl, method: .delete, params: body, encoding: JSONEncoding.default,
                hasHeader: true).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                let result = JSON(data)
                complete(result, nil)
                break
            case .failure(let error):
                complete(nil, error)
                break
            }
        }
    }
    
    // MARK: - Token
    
    // MARK: - Account
}

