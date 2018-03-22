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
import Crashlytics

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
            formData.append(data, withName: "image", fileName: "attachment.jpg", mimeType: "image/jpg")
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
                
                CLS_LOG_SWIFT(format: ">>>> POST RESPONSE: %@\n%@", [url, result.description])
                
                complete(result, nil)
                break
            case .failure(let error):
                
                CLS_LOG_SWIFT(format: ">>>> POST ERROR RESPONSE: %@\n%@", [url, error.localizedDescription])
                
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
                
                CLS_LOG_SWIFT(format: ">>>> GET RESPONSE: %@\n%@", [url, result.description])
                
                complete(result, nil)
                break
            case .failure(let error):
                
                CLS_LOG_SWIFT(format: ">>>> GET ERROR RESPONSE: %@\n%@", [url, error.localizedDescription])
                
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
                
                CLS_LOG_SWIFT(format: ">>>> DELETE RESPONSE: %@\n%@", [url, result.description])
                
                complete(result, nil)
                break
            case .failure(let error):
                
                CLS_LOG_SWIFT(format: ">>>> DELETE ERROR RESPONSE: %@\n%@", [url, error.localizedDescription])
                
                complete(nil, error)
                break
            }
        }
    }
    
    // MARK: - Token
    func oauthToken(user: String, password: String, grantType: String = "password", complete: @escaping BoolStringClosure) -> Void {
        
        CLS_LOG_SWIFT(format: "Auth token user: %@, password: %@", [user, password])
        
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
                    CLS_LOG_SWIFT(format: "Auth token response: %@", [response.description])
                    
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
    
    func clearToken() {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: TOKEN_KEY)
        userDefaults.removeObject(forKey: EXPIRE_KEY)
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
    func accountLogin(email: String, password: String, complete: @escaping UserProfileModelResponse) -> Void {
        
        print("TOKEN", self.getToken() ?? "NOTHING")
        
        let body = [
            "email": email,
            "password": password,
        ]
        
        CLS_LOG_SWIFT(format: "Login url: %@ \nbody: %@", [URLManager.Account.Login, body])
        
        POST(url: URLManager.Account.Login, body: body) { (json, error) in
            
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success == true,
                    let userProfile = JGGUserProfileModel(json: response[VALUE_KEY]) {
                    complete(userProfile, nil)
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
        
        CLS_LOG_SWIFT(format: "Register url: %@ \nbody: %@", [URLManager.Account.Register, body])
        
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
        
        CLS_LOG_SWIFT(format: "accountAddPhone url: %@ \nbody: %@", [URLManager.Account.AddPhoneNumber, body])

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
    
    func verifyPhoneNumber(_ phoneNumber: String, code: String, complete: @escaping UserProfileModelResponse) -> Void {
        let body = [
            "Provider": phoneNumber,
            "Code": code
        ]
        CLS_LOG_SWIFT(format: "verifyPhoneNumber url: %@ \nbody: %@", [URLManager.Account.VerifyCode, body])

        POST(url: URLManager.Account.VerifyCode, body: body) { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success == true,
                    let userProfile = JGGUserProfileModel(json: response[VALUE_KEY])
                {
                    complete(userProfile, nil)
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
            self.clearToken()
            complete(true, nil)
        }
    }
    
    // MARK: - User
    func userEditProfile(email: String, regionId: String, data: JSON, complete: @escaping BoolStringClosure) -> Void {
        if var body = data.dictionaryObject {
            body["Email"] = email
            body["RegionID"] = regionId
            
            CLS_LOG_SWIFT(format: "userEditProfile url: %@ \nbody: %@", [URLManager.User.EditProfile, body])
            
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
        
        CLS_LOG_SWIFT(format: "Get regions")
        
        GET(url: URLManager.System.GetRegions, params: nil) { (json, error) in
            
            CLS_LOG_SWIFT(format: "Get region response: %@", [json?.description ?? ""])
            
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
    
    // MARK: - Appointments
    func getPendingJobs(user: JGGUserProfileModel, pageIndex: Int = 0, pageSize: Int = 20, _ complete: @escaping AppointmentsClosure) -> Void {
        
        guard let userProfileId = user.id else {
            complete([])
            print("Get Peding Job: [ERROR]: No user profile id")
            return
        }
        
        CLS_LOG_SWIFT(format: "getPendingJobs url: %@", [URLManager.Appointment.GetPendingAppointments()])
        let params: Dictionary = [
            "UserProfileID": userProfileId,
            "PageIndex": pageIndex,
            "PageSize": pageSize,
        ]
        getAppointmentsArray(
            method: .get,
            url: URLManager.Appointment.GetPendingAppointments(),
            params: params,
            complete
        )
    }
    
    fileprivate func getAppointmentsArray(method: HTTPMethod, url: String, params: Dictionary?, _ complete: @escaping AppointmentsClosure) {
        let completeClosure: DefaultResponse = { (json, error) in
            if let response = json {
                let success = response[SUCCESS_KEY].boolValue
                if success {
                    var jobs: [JGGJobModel] = []
                    for jsonJob in response[VALUE_KEY].arrayValue {
                        if let job = JGGJobModel(json: jsonJob) {
                            jobs.append(job)
                        }
                    }
                    complete(jobs)
                    return
                }
            }
            complete([])
        }
        if method == .get {
            GET(url: url, params: params, complete: completeClosure)
        } else if method == .post {
            POST(url: url, body: params, complete: completeClosure)
        } else {
            complete([])
        }
    }
    
    // MARK: - Search
    fileprivate func searchAppointments(
        type: JGGAppointmentType,
        regionId: String? = nil,
        userProfileId: String? = nil,
        query: String? = nil,
        categoryId: String? = nil,
        tag: String? = nil,
        postedOn: String? = nil,
        lat: Double? = nil,
        lon: Double? = nil,
        distance: Double? = nil,
        pageIndex: Int = 0,
        pageSize: Int = 20,
        _ complete: @escaping AppointmentsClosure) -> Void
    {
        var params: Dictionary = [:]
        if let regionId      = regionId         { params["RegionID"] = regionId }
        if let userProfileId = userProfileId    { params["UserProfileID"] = userProfileId }
        if let query         = query            { params["Query"] = query }
        if let categoryId    = categoryId       { params["CategoryID"] = categoryId }
        if let tag           = tag              { params["Tag"] = tag }
        if let postedOn      = postedOn         { params["PostedOn"] = postedOn }
        if let lat           = lat              { params["Lat"] = lat }
        if let lon           = lon              { params["Lon"] = lon }
        if let distance = distance              { params["Distance"] = distance }
        params["PageIndex"] = pageIndex
        params["PageSize"] = pageSize
        var url: String
        if type == .job {
            url = URLManager.Appointment.SearchJob
        } else if type == .service {
            url = URLManager.Appointment.SearchService
        } else {
            complete([])
            return
        }
        getAppointmentsArray(
            method: .post,
            url: url,
            params: params,
            complete
        )
    }
    
    func searchJobs(
        regionId: String? = nil,
        userProfileId: String? = nil,
        query: String? = nil,
        categoryId: String? = nil,
        tag: String? = nil,
        postedOn: String? = nil,
        lat: Double? = nil,
        lon: Double? = nil,
        distance: Double? = nil,
        pageIndex: Int = 0,
        pageSize: Int = 20,
        _ complete: @escaping AppointmentsClosure) -> Void
    {
        searchAppointments(
            type: .job,
            regionId: regionId,
            userProfileId: userProfileId,
            query: query,
            categoryId: categoryId,
            tag: tag,
            postedOn: postedOn,
            lat: lat,
            lon: lon,
            distance: distance,
            pageIndex: pageIndex,
            pageSize: pageSize,
            complete
        )
    }
    
    func searchServices(
        regionId: String? = nil,
        userProfileId: String? = nil,
        query: String? = nil,
        categoryId: String? = nil,
        tag: String? = nil,
        postedOn: String? = nil,
        lat: Double? = nil,
        lon: Double? = nil,
        distance: Double? = nil,
        pageIndex: Int = 0,
        pageSize: Int = 20,
        _ complete: @escaping AppointmentsClosure) -> Void
    {
        searchAppointments(
            type: .service,
            regionId: regionId,
            userProfileId: userProfileId,
            query: query,
            categoryId: categoryId,
            tag: tag,
            postedOn: postedOn,
            lat: lat,
            lon: lon,
            distance: distance,
            pageIndex: pageIndex,
            pageSize: pageSize,
            complete
        )
    }
    
    // MARK: - Job
    func getCategories(_ complete: @escaping CategoryListClosure) -> Void {
        CLS_LOG_SWIFT(format: "getCategories url: %@", [URLManager.System.GetAllCategories])
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
    
    func postJob(_ job: JGGJobModel, complete: @escaping StringStringClosure) -> Void
    {
        CLS_LOG_SWIFT(format: "postJob url: %@\nBODY: %@", [URLManager.Appointment.PostJob, job.json().description])
        print(job.json().description)
        POST(url: URLManager.Appointment.PostJob, body: job.json().dictionaryObject) { (json, error) in
            if let response = json {
                print("response: ", response)
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
    
    func editJob(_ job: JGGJobModel, complete: @escaping StringStringClosure) -> Void
    {
        CLS_LOG_SWIFT(format: "editJob url: %@\nBODY: %@", [URLManager.Appointment.PostJob, job.json().description])
        print(job.json().description)
        POST(url: URLManager.Appointment.EditJob, body: job.json().dictionaryObject) { (json, error) in
            if let response = json {
                print("response: ", response)
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
    
    func deleteJob(_ job: JGGJobModel, reason: String?, complete: @escaping BoolStringClosure) -> Void {
        
        if let jobId = job.id {
            
            GET(
                url: URLManager.Appointment.DeleteJob,
                params: ["id": jobId],
                complete: { (json, error) in
                    if let response = json {
                        print("DELETE response: ", response)
                        complete(response[SUCCESS_KEY].boolValue, response[MESSAGE_KEY].string)
                    } else if let error = error {
                        complete(false, error.localizedDescription)
                    } else {
                        complete(false, LocalizedString("Unknown request error."))
                    }
                }
            )
            
        } else {
            complete(false, LocalizedString("Can't know Job ID"))
        }
        
    }
    
    // MARK: - Service
    func postService(_ service: JGGJobModel, complete: @escaping StringStringClosure) -> Void
    {
//        CLS_LOG_SWIFT(format: "postService url: %@\nBODY: %@", [URLManager.Appointment.PostService, service.json().description])
        print(service.json().description)
        POST(url: URLManager.Appointment.PostService, body: service.json().dictionaryObject) { (response, error) in
            if let json = response {
                let success = json[SUCCESS_KEY].boolValue
                if success {
                    complete(json[VALUE_KEY].stringValue, nil)
                } else {
                    complete(nil, json[MESSAGE_KEY].stringValue)
                }
            } else if let error = error {
                complete(nil, error.localizedDescription)
            } else {
                complete(nil, LocalizedString("Unknown request error."))
            }
        }
    }
    
    // MARK: - Proposal
    func postProposal(_ proposal: JGGProposalModel, user: JGGUserProfileModel, complete: @escaping StringStringClosure) -> Void {
        
//        CLS_LOG_SWIFT(format: "postProposal url: %@\nBODY: %@", [URLManager.Proposal.PostProposal, proposal.json().description])
        print(proposal.json().description)
        proposal.currencyCode = proposal.appointment?.currencyCode
        POST(url: URLManager.Proposal.PostProposal, body: proposal.json().dictionaryObject) { (response, error) in
            if let json = response {
                let success = json[SUCCESS_KEY].boolValue
                if success {
                    complete(json[VALUE_KEY].stringValue, nil)
                } else {
                    complete(nil, json[MESSAGE_KEY].stringValue)
                }
            } else if let error = error {
                complete(nil, error.localizedDescription)
            } else {
                complete(nil, LocalizedString("Unknown request error."))
            }
        }
    }
    
    func editProposal(_ proposal: JGGProposalModel, _ complete: @escaping BoolStringClosure) -> Void {
        print("EDIT proposal: ", proposal.json().description)
        POST(url: URLManager.Proposal.EditProposal, body: proposal.json().dictionaryObject) { (response, error) in
            if let json = response {
                let success = json[SUCCESS_KEY].boolValue
                complete(success, json[MESSAGE_KEY].string)
            } else if let error = error {
                complete(false, error.localizedDescription)
            } else {
                complete(false, LocalizedString("Unknown request error."))
            }
        }
    }
    
    func deleteProposal(_ proposal: JGGProposalModel, _ complete: @escaping BoolStringClosure) -> Void {
        print("DELETE proposal: ", proposal.json().description)
        GET(url: URLManager.Proposal.DeleteProposal(id: proposal.id!), params: nil) { (response, error) in
            if let json = response {
                let success = json[SUCCESS_KEY].boolValue
                complete(success, json[MESSAGE_KEY].string)
            } else if let error = error {
                complete(false, error.localizedDescription)
            } else {
                complete(false, LocalizedString("Unknown request error."))
            }
        }
    }
    
    func sendInvite(appointment: JGGJobModel, user: JGGUserProfileModel, complete: @escaping BoolStringClosure) -> Void {
        if let appointmentID = appointment.id, let userProfileID = user.id {
            let params: Dictionary = [
                "AppointmentID": appointmentID,
                "UserProfileID": userProfileID
            ]
            let url = URLManager.Proposal.SendInvite
            POST(url: url, body: params, complete: { (response, error) in
                if let json = response {
                    let success = json[SUCCESS_KEY].boolValue
                    complete(success, nil)
                } else if let error = error {
                    complete(false, error.localizedDescription)
                } else {
                    complete(false, LocalizedString("Unknown request error."))
                }
            })
        }
    }
    
    func approveProposal() -> Void {
        
    }
    
    func rejectProposal(id: String) -> Void {
        
    }
    
    func getProposalsBy(
        jobId: String,
        pageIndex: Int = 0,
        pageSize: Int = 20,
        complete: @escaping ProposalsClosure) -> Void
    {
        let url = URLManager.Proposal.GetProposalsByJob(id: jobId, pageIndex: pageIndex, pageSize: pageSize)
        GET(url: url, params: nil) { (response, error) in
            if let json = response {
                let success = json[SUCCESS_KEY].boolValue
                if success {
                    var proposals: [JGGProposalModel] = []
                    for jsonProposal in json[VALUE_KEY].arrayValue {
                        if let proposal = JGGProposalModel(json: jsonProposal) {
                            proposals.append(proposal)
                        }
                    }
                    complete(proposals)
                    return
                }
            } else {
                complete([])
                print("getProvidersForInvite ERROR: ", error ?? "")
            }
        }
    }
    
    func getProvidersForInvite(
        pageIndex: Int = 0,
        pageSize: Int = 20,
        categoryID: String? = nil,
        city: String? = nil,
        state: String? = nil,
        postalCode: String? = nil,
        lat: Double? = nil,
        lon: Double? = nil,
        complete: @escaping ProvidersClosure) -> Void
    {
        var params: Dictionary = [
            "pageIndex": pageIndex,
            "pageSize": pageSize
        ]
        if let categoryID = categoryID {
            params["CategoryID"] = categoryID
        }
        if let city = city  {
            params["City"] = city
        }
        if let state = state  {
            params["State"] = state
        }
        if let postalCode = postalCode {
            params["PostalCode"] = postalCode
        }
        if let lat = lat, let lon = lon {
            params["lat"] = lat
            params["lon"] = lon
        }
        let url = URLManager.Proposal.GetUsersForInvite
        POST(url: url, body: params) { (response, error) in
            if let json = response {
                let success = json[SUCCESS_KEY].boolValue
                if success {
                    var providers: [JGGUserProfileModel] = []
                    for jsonProvider in json[VALUE_KEY].arrayValue {
                        if let user = JGGUserProfileModel(json: jsonProvider) {
                            providers.append(user)
                        }
                    }
                    complete(providers)
                    return
                }
            } else {
                complete([])
                print("getProvidersForInvite ERROR: ", error ?? "")
            }
        }
    }
    
    func getProposedStatus(jobId: String, userProfileId: String, _ complete: @escaping ProposalClosure) -> Void {
        let url = URLManager.Proposal.GetProposedStatus(jobId: jobId, userProfileId: userProfileId)
        GET(url: url, params: nil) { (response, error) in
            if let json = response {
                let success = json[SUCCESS_KEY].boolValue
                if success {
                    let proposal = JGGProposalModel(json: json[VALUE_KEY].arrayValue.first)
                    complete(proposal)
                    return
                }
            }
            complete(nil)
            print("getProposedStatus ERROR: ", error ?? "")
        }
    }
}

