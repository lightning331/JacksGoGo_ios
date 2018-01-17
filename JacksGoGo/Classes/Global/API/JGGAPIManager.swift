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

private let SUCCESS_KEY                  = "Success"
private let VALUE_KEY                    = "Value"
private let MESSAGE_KEY                  = "Message"

class JGGAPIManager: NSObject {

    private let HEADER_AUTHORIZATION         = "Authorization"
    private let HEADER_VALUE_PREFIX          = "Bearer"
    
    
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
        if let token = self.getToken(), hasHeader == true {
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
    
    func upload(url: String, data: Data, progressClosure: ProgressClosure? = nil, complete: @escaping StringStringClosure) {
//        var header: [String: String]?
//        if let token = self.getToken() {
//            header = [
//                HEADER_AUTHORIZATION : HEADER_VALUE_PREFIX + " " + token,
//            ]
//        }
        
        
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(data, withName: "image", mimeType: "image/jpg")
        }, to: url) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    if let progressClosure = progressClosure {
                        let percent = Float(progress.completedUnitCount) / Float(progress.totalUnitCount)
                        progressClosure(percent)
                    }
                })
                
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        let result = JSON(data)
                        if let success = result[SUCCESS_KEY].bool, success == true {
                            complete(result[VALUE_KEY].string, nil)
                        } else {
                            complete(nil, result[MESSAGE_KEY].string)
                        }
                        break
                    case .failure(let error):
                        complete(nil, error.localizedDescription)
                        break
                    }
                }
                
            case .failure(let encodingError):
                complete(nil, encodingError.localizedDescription)
            }
        }
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
    func oauthToken(user: String, password: String, grantType: String = "password", complete: @escaping BoolStringClosure) -> Void {
        let params: Dictionary = [
            "username": user,
            "password": password,
            "grant_type": grantType
        ]
        request(url: URLManager.oauthToken,
                method: .post,
                params: params,
                encoding: URLEncoding.httpBody,
                hasHeader: false).responseJSON { (response) in
                    
            switch response.result {
            case .success(let data):
                let result = JSON(data)
                print(result)
                if let _ = result["error"].string {
                    complete(false, result["error_description"].stringValue)
                } else {
                    let accessToken = result["access_token"].stringValue
                    let expiresIn = result["expires_in"].doubleValue
                    self.save(token: accessToken, expiresIn: expiresIn)
                    complete(true, nil)
                }
                break
            case .failure(let error):
                print(error)
                complete(false, error.localizedDescription)
                break
            }
        }
    }
    
    let TOKEN_KEY = "TOKEN"
    let EXPIRE_KEY = "EXPIRE"
    
    func save(token: String, expiresIn: Double) -> Void {
        let expiresDate = Date(timeIntervalSinceNow: expiresIn)
        let userDefaults = UserDefaults.standard
        userDefaults.set(token, forKey: TOKEN_KEY)
        userDefaults.set(expiresDate, forKey: EXPIRE_KEY)
        userDefaults.synchronize()
    }
    
    func getToken() -> String? {
        let userDefaults = UserDefaults.standard
        if let token = userDefaults.string(forKey: TOKEN_KEY),
           let expiresDate = userDefaults.object(forKey: EXPIRE_KEY) as? Date
        {
            if expiresDate > Date() {
                return token
            }
        }
        return nil
    }
    
    // MARK: - Account
    func accountLogin(email: String, password: String, complete: @escaping UserModelResponse) -> Void {
        let body = [
            "email": email,
            "password": password,
        ]
        POST(url: URLManager.Account.Login, body: body) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success {
                    let user = JGGUserBaseModel(json: response[VALUE_KEY])
                    complete(user, nil)
                } else {
                    let errorMessage = response[MESSAGE_KEY].stringValue
                    complete(nil, errorMessage)
                }
            } else if let error = error {
                print(error)
                complete(nil, error.localizedDescription)
            } else {
                complete(nil, LocalizedString("Unknown request error."))
            }
        }
    }
    
    func accountRegister(email: String, password: String, complete: @escaping BoolStringClosure) -> Void {
        let body = [
            "email": email,
            "password": password,
            ]
        POST(url: URLManager.Account.Register, body: body) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                
                if success {
                    self.oauthToken(user: email, password: password, complete: complete)
                } else {
                    let message = response[MESSAGE_KEY].stringValue
                    complete(success, message)
                }
                
            } else if let error = error {
                print(error)
                complete(false, error.localizedDescription)
            } else {
                complete(false, LocalizedString("Unknown request error."))
            }
        }
    }
    
    func accountAddPhone(_ phoneNumber: String, complete: @escaping BoolStringClosure) -> Void {
        let body = [
            "Number": phoneNumber
        ]
        POST(url: URLManager.Account.AddPhoneNumber, body: body) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                let message = response[MESSAGE_KEY].stringValue
                complete(success, message)
            } else if let error = error {
                print(error)
                complete(false, error.localizedDescription)
            } else {
                complete(false, LocalizedString("Unknown request error."))
            }
        }
    }
    
    func verifyPhoneNumber(_ phoneNumber: String, code: String, complete: @escaping UserModelResponse) -> Void {
        let body = [
            "Provider": phoneNumber,
            "Code": code
        ]
        POST(url: URLManager.Account.VerifyCode, body: body) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success {
                    let user = JGGUserBaseModel(json: response[VALUE_KEY])
                    complete(user, nil)
                } else {
                    let errorMessage = response[MESSAGE_KEY].stringValue
                    complete(nil, errorMessage)
                }
            } else if let error = error {
                print(error)
                complete(nil, error.localizedDescription)
            } else {
                complete(nil, LocalizedString("Unknown request error."))
            }
        }
    }
    
    func accountLogout(_ complete: @escaping BoolStringClosure) -> Void {
        POST(url: URLManager.Account.Logout, body: nil) { (response, error) in
            complete(true, nil)
        }
    }
    
    // MARK: - User
    func userEditProfile(email: String, regionId: String, data: JSON, complete: @escaping BoolStringClosure) -> Void {
        if var body = data.dictionaryObject {
            body["Email"] = email
            body["RegionID"] = regionId
            POST(url: URLManager.User.EditProfile, body: body) { (json, error) in
                if let response = json {
                    let success = response[SUCCESS_KEY].boolValue
                    let message = response[MESSAGE_KEY].stringValue
                    complete(success, message)
                } else if let error = error {
                    print(error)
                    complete(false, error.localizedDescription)
                } else {
                    complete(false, LocalizedString("Unknown request error."))
                }
            }
        } else {
            complete(false, "No changed information.")
        }
    }
    
    // MARK: - System
    func getRegions(_ complete: @escaping RegionListClosure) -> Void {
        GET(url: URLManager.System.GetRegions, params: nil) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success {
                    var regions: [JGGRegionModel] = []
                    for jsonRegion in response[VALUE_KEY].arrayValue {
                        if let region = JGGRegionModel(json: jsonRegion) {
                            regions.append(region)
                        }
                    }
                    complete(regions)
                    return
                }
            }
            complete([])
            
        }
    }
    
    private func upload(image: UIImage,
                        url: String,
                        progressClosure: ProgressClosure? = nil,
                        complete: @escaping StringStringClosure)
    {
        if let imageData = UIImageJPEGRepresentation(image, 0.7) {
            upload(url: url,
                   data: imageData,
                   progressClosure: progressClosure,
                   complete: complete)
        } else {
            complete(nil, LocalizedString("Wrong type image"))
        }
    }
    
    func upload(attachmentImage: UIImage, progressClosure: ProgressClosure? = nil, complete: @escaping StringStringClosure) -> Void {
        upload(image: attachmentImage,
               url: URLManager.System.UploadAttachmentFile,
               progressClosure: progressClosure,
               complete: complete)
    }
    
    func upload(profileImage: UIImage, progressClosure: ProgressClosure? = nil, complete: @escaping StringStringClosure) -> Void {
        upload(image: profileImage,
               url: URLManager.System.UploadProfileImage,
               progressClosure: progressClosure,
               complete: complete)
    }
    
    func upload(systemImage: UIImage, progressClosure: ProgressClosure? = nil, complete: @escaping StringStringClosure) -> Void {
        upload(image: systemImage,
               url: URLManager.System.UploadSystemFile,
               progressClosure: progressClosure,
               complete: complete)
    }
    
    // Job
    func getCategories(_ complete: @escaping CategoryListClosure) -> Void {
        GET(url: URLManager.System.GetAllCategories, params: nil) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success {
                    var categories: [JGGCategoryModel] = []
                    for jsonCategory in response[VALUE_KEY].arrayValue {
                        if let category = JGGCategoryModel(json: jsonCategory) {
                            categories.append(category)
                        }
                    }
                    complete(categories)
                    return
                }
            }
            complete([])
        }
    }
    
    func postJob(_ job: JGGCreateJobModel, complete: @escaping StringStringClosure) -> Void
    {
        POST(url: URLManager.Appointment.PostJob, body: job.json().dictionaryObject) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success {
                    complete(response[VALUE_KEY].stringValue, nil)
                } else {
                    complete(nil, response[MESSAGE_KEY].stringValue)
                }
            } else if let error = error {
                complete(nil, error.localizedDescription)
            } else {
                complete(nil, LocalizedString("Unknown request error."))
            }
            
        }
        
    }
    
}

