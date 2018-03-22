//
//  URLManager.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import Foundation

class URLManager: NSObject {
    
    fileprivate static func fullPath(for endPoint: String) -> String {
#if DEBUG
    return "http://www.meridians2.com/JGGdev/api" + endPoint
//        return "http://192.168.0.30:50370/api" + endPoint
#else
        return "http://www.meridians2.com/JGGdev/api" + endPoint
#endif
    }
    
    static var oauthToken: String {
#if DEBUG
//        return "http://192.168.0.30:50370/oauth/Token"
    return "http://www.meridians2.com/JGGdev/oauth/Token"

#else
        return "http://www.meridians2.com/JGGdev/oauth/Token"
#endif
    }
    
    // MARK: - Account
    class Account: NSObject {
        
        private static func fullPath(for endPoint: String) -> String {
            return URLManager.fullPath(for: "/Account" + endPoint)
        }
        
        static var AddPhoneNumber: String {
            return fullPath(for: "/AddPhoneNumber")
        }
        
        static var VerifyCode: String {
            return fullPath(for: "/VerifyCode")
        }
        
        static var Login: String {
            return fullPath(for: "/Login")
        }
        
        static var Register: String {
            return fullPath(for: "/Register")
        }
        
        static var UploadPhoto: String {
            return fullPath(for: "/UploadPhoto")
        }
        
        static var ChangePassword: String {
            return fullPath(for: "/ChangePassword")
        }
        
        static var UserInfo: String {
            return fullPath(for: "/UserInfo")
        }
        
        static var Logout: String {
            return fullPath(for: "/Logout")
        }
        
        static var AddExternalLogin: String {
            return fullPath(for: "/AddExternalLogin")
        }
        
    }
    
    class Appointment: NSObject {
        
        private static func fullPath(for endPoint: String) -> String {
            return URLManager.fullPath(for: "/Appointment" + endPoint)
        }
        
        // Appointment
        static func ApproveAppointment(id: String) -> String {
            return fullPath(for: "/ApproveAppointment?ID=\(id)")
        }
        
        static func GetPendingAppointments() -> String {
            return fullPath(for: "/GetPendingAppointments")
        }
        
        static func GetConfirmedAppointments() -> String {
            return fullPath(for: "/GetConfirmedAppointments")
        }
        
        static func GetAppointmentHistory() -> String {
            return fullPath(for: "/GetAppointmentHistory")
        }
        
        // Jobs
        static var PostJob: String {
            return fullPath(for: "/PostJob")
        }
        
        static var SendQuotation: String {
            return fullPath(for: "/SendQuotation")
        }
        
        static var DeleteJob: String {
            return fullPath(for: "/DeleteJob")
        }
        
        static var EditJob: String {
            return fullPath(for: "/EditJob")
        }
        
        static var SearchJob: String {
            return fullPath(for: "/SearchJob")
        }
        
        static var GetJobsByUser: String {
            return fullPath(for: "/GetJobsByUser")
        }
        
        static var GetJobsByCategory: String {
            return fullPath(for: "/GetJobsByCategory")
        }
        
        static var GetJobsByRegion: String {
            return fullPath(for: "/GetJobsByRegion")
        }
        
        static var GetAllJobs: String {
            return fullPath(for: "/GetAllJobs")
        }
        
        static var GetJobByID: String {
            return fullPath(for: "/GetJobByID")
        }
        
        // Service
        static var PostService: String {
            return fullPath(for: "/PostService")
        }
        
        static func DeleteService(id: String) -> String {
            return fullPath(for: "/DeleteService?ID=\(id)")
        }
        
        static var EditService: String {
            return fullPath(for: "/EditService")
        }
        
        static func SendReschedulingRequest(id: String) -> String {
            return fullPath(for: "/SendReschedulingRequest?ID=\(id)")
        }
        
        static func DeclineReschedulingRequest(id: String) -> String {
            return fullPath(for: "/DeclineReschedulingRequest?ID=\(id)")
        }
        
        static func AgreeReschedulingRequest(id: String) -> String {
            return fullPath(for: "/AgreeReschedulingRequest?ID=\(id)")
        }
        
        static var SearchService: String {
            return fullPath(for: "/SearchService")
        }
        
        static var GetServicesByUser: String {
            return fullPath(for: "/GetServicesByUser")
        }
        
        static var GetServicesByCategory: String {
            return fullPath(for: "/GetServicesByCategory")
        }
        
        static var GetServiceByID: String {
            return fullPath(for: "/GetServiceByID")
        }

    }
    
    class Proposal: NSObject {
        
        private static func fullPath(for endPoint: String) -> String {
            return URLManager.fullPath(for: "/Proposal" + endPoint)
        }

        static var PostProposal: String {
            return fullPath(for: "/PostProposal")
        }
        
        static var EditProposal: String {
            return fullPath(for: "/EditProposal")
        }
        
        static var SendInvite: String {
            return fullPath(for: "/SendInvite")
        }
        
        static var ApproveProposal: String {
            return fullPath(for: "/ApproveProposal")
        }
        
        static func RejectProposal(id: String) -> String {
            return fullPath(for: "/RejectProposal?ID=\(id)")
        }
        
        static func WithdrawProposal(id: String) -> String {
            return fullPath(for: "/WithdrawProposal?ID=\(id)")
        }
        
        static func DeleteProposal(id: String) -> String {
            return fullPath(for: "/DeleteProposal?ProposalID=\(id)")
        }
        
        static func GetProposalsByJob(id: String, pageIndex: Int = 0, pageSize: Int = 20) -> String {
            return fullPath(for: String(format: "/GetProposalsByJob?ID=\(id)&pageIndex=\(pageIndex)&pageSize=\(pageSize))"))
        }
        
        static func GetProposalsByUser(id: String, pageIndex: Int = 0, pageSize: Int = 20) -> String {
            return fullPath(for: String(format: "/GetProposalsByUser?ID=\(id)&pageIndex=\(pageIndex)&pageSize=\(pageSize))"))
        }
        
        static var GetUsersForInvite: String {
            return fullPath(for: "/GetUsersForInvite")
        }
        
        static func GetProposedStatus(jobId: String, userProfileId: String) -> String {
            return fullPath(for: "/GetProposedStatus?JobID=\(jobId)&UserProfileID=\(userProfileId)")
        }
    }
    
    class User: NSObject {
        
        private static func fullPath(for endPoint: String) -> String {
            return URLManager.fullPath(for: "/User" + endPoint)
        }
        
        static var EditProfile: String {
            return fullPath(for: "/EditProfile")
        }
        
        static var AddCategory: String {
            return fullPath(for: "/AddCategory")
        }
        
        static var DeleteCategory: String {
            return fullPath(for: "/DeleteCategory")
        }
        
        static var GetCategories: String {
            return fullPath(for: "/GetCategories")
        }
        
        static var AddLanguage: String {
            return fullPath(for: "/AddLanguage")
        }
        
        static var DeleteLanguage: String {
            return fullPath(for: "/DeleteLanguage")
        }
        
        static var GetLanguages: String {
            return fullPath(for: "/GetLanguages")
        }
        
    }
    
    class Service: NSObject {
        
        private static func fullPath(for endPoint: String) -> String {
            return URLManager.fullPath(for: "/Service" + endPoint)
        }
        
        
    }
    
    class System: NSObject {
        private static func fullPath(for endPoint: String) -> String {
            return URLManager.fullPath(for: endPoint)
        }
        
        static var UploadAttachmentFile: String {
            return fullPath(for: "/UpLoad/UploadAttachmentFile")
        }
        
        static var UploadProfileImage: String {
            return fullPath(for: "/UpLoad/UploadProfileImage")
        }
        
        static var UploadSystemFile: String {
            return fullPath(for: "/UpLoad/UploadSystemFile")
        }

        static var AddCategory: String {
            return fullPath(for: "/Category/AddCategory")
        }
        
        static var EditCategory: String {
            return fullPath(for: "/Category/EditCategory")
        }
        
        static var DeleteCategory: String {
            return fullPath(for: "/Category/DeleteCategory")
        }
        
        static var GetAllCategories: String {
            return fullPath(for: "/Category/GetAllCategories")
        }
        
        static var AddCountry: String {
            return fullPath(for: "/Country/AddCountry")
        }
        
        static var EditCountry: String {
            return fullPath(for: "/Country/EditCountry")
        }
        
        static var DeleteCountry: String {
            return fullPath(for: "/Country/DeleteCountry")
        }
        
        static var GetCountries: String {
            return fullPath(for: "/Country/GetCountries")
        }
        
        static var AddCurrency: String {
            return fullPath(for: "/Currency/AddCurrency")
        }
        
        static var EditCurrency: String {
            return fullPath(for: "/Currency/EditCurrency")
        }
        
        static var GetCurrencies: String {
            return fullPath(for: "/Currency/GetCurrencies")
        }
        
        static var AddLanguage: String {
            return fullPath(for: "/Language/AddLanguage")
        }
        
        static var EditLanguage: String {
            return fullPath(for: "/Language/EditLanguage")
        }
        
        static var DeleteLanguage: String {
            return fullPath(for: "/Language/DeleteLanguage")
        }
        
        static var GetLanguages: String {
            return fullPath(for: "/Language/GetLanguages")
        }
        
        static var AddRegion: String {
            return fullPath(for: "/Region/AddRegion")
        }
        
        static var EditRegion: String {
            return fullPath(for: "/Region/AddRegion")
        }
        
        static var DeleteRegion: String {
            return fullPath(for: "/Region/DeleteRegion")
        }
        
        static var GetRegions: String {
            return fullPath(for: "/Region/GetRegions")
        }
        
        
    }
    
    
}
