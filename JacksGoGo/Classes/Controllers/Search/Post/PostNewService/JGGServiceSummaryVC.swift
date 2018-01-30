//
//  JGGServiceSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import TagListView
import MBProgressHUD

class JGGServiceSummaryVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var btnTimeSlot: UIButton!
    @IBOutlet weak var btnAddress: UIButton!
    
    @IBOutlet weak var lblDescribeTitle: UILabel!
    @IBOutlet weak var lblDescribeContent: UILabel!
    @IBOutlet weak var serviceTagView: TagListView!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnViewTimeSlots: UIButton!
    
    @IBOutlet weak var lblAddress: UILabel!
    
    var creatingService: JGGCreateJobModel?

    private var hud: MBProgressHUD!
    private lazy var imageDownloadURLs: [String] = []

    var isRequestQuotationMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showServiceData()
        
        if !isRequestQuotationMode {
//            self.tableView.tableFooterView = nil
        }
    }
    
    fileprivate func showServiceData() {
        if let creatingService = creatingService {
            lblDescribeTitle.text = creatingService.title
            lblDescribeContent.text = creatingService.description_
            let tags = creatingService.tags?.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            if tags != nil { serviceTagView.addTags(tags!) }
            
            var budget: String
            if creatingService.serviceType < 2 {
                if let fixedAmount = creatingService.budget {
                    budget = String(format: "Fixed $ %.02f", fixedAmount)
                } else if let minAmount = creatingService.budgetFrom,
                    let maxAmount = creatingService.budgetTo
                {
                    budget = String(format: "From $ %.02f to $ %.02f", minAmount, maxAmount)
                } else {
                    budget = "No set"
                }
            } else {
                budget = String(format: "%d Services", creatingService.serviceType)
                if let price = creatingService.budget {
                    budget += String(format: ", $ %.02f per service", price)
                }
            }
            lblPrice.text = budget
            
            // Address
            lblAddress.text = creatingService.address?.fullName
        } else {
            lblDescribeTitle.text = LocalizedString("No title")
            lblDescribeContent.text = nil
            serviceTagView.removeAllTags()
            lblPrice.text = LocalizedString("No set")
            lblAddress.text = LocalizedString("No set")
        }
    }
    
    /*
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let index = self.navigationController?.viewControllers.index(of: self),
            index > 0,
            isRequestQuotationMode == true
        {
            let vcs = [self]
            self.navigationController?.viewControllers = vcs
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.hidesBarsOnSwipe = false
        }
    } */
    
    @IBAction func onPressedEditService(_ sender: UIButton) {
        if let stepRootVC = self.navigationController?.viewControllers.first as? JGGPostServiceStepRootVC {
            var index: Int = 0
            if sender == btnDescribe {
                index = 0
            }
            else if sender == btnPrice {
                index = 1
            }
            else if sender == btnTimeSlot || sender == btnViewTimeSlots {
                index = 2
            }
            else if sender == btnAddress {
                index = 3
            }
            stepRootVC.stepView.selectStep(index: index)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPressedRequestQuotation(_ sender: UIButton) {
        
        if isRequestQuotationMode {
            
        } else {
            if let creatingService = creatingService {
                hud = MBProgressHUD.showAdded(to: self.parent!.parent!.parent!.view, animated: true)
                
                if self.imageDownloadURLs.count == 0 {
                    hud.mode = .annularDeterminate
                    hud.label.text = LocalizedString("Uploading photos")
                    hud.show(animated: true)
                    uploadPhotos(creatingService.attachmentImages ?? [], index: 0) {
                        self.postService(creatingService)
                    }
                } else {
                    self.postService(creatingService)
                }
            }
        }
    }
    
    private func uploadPhotos(_ photos:[UIImage], index: Int, complete: @escaping VoidClosure) {
        if index < photos.count {
            let image = photos[index]
            APIManager.upload(attachmentImage: image, progressClosure: { (percent) in
                let totalPercent = (Float(index) + percent) / Float(photos.count)
                print (percent, totalPercent)
                self.hud.progress = totalPercent
            }, complete: { (downloadUrl, errorMessage) in
                if let url = downloadUrl {
                    self.imageDownloadURLs.append(url)
                }
                self.uploadPhotos(photos, index: index + 1, complete: complete)
            })
        } else {
            complete()
        }
    }
    
    private func postService(_ creatingService: JGGCreateJobModel) {
        self.hud.mode = .indeterminate
        self.hud.label.text = LocalizedString("Posting Service")
        
        creatingService.attachmentUrl = self.imageDownloadURLs
        self.APIManager.postService(creatingService, complete: { (serviceId, errorMessage) in
            if let serviceId = serviceId {
                creatingService.id = serviceId
                let message = String(format: LocalizedString("Service reference no.: %@\nOur team will verify your submission and get back to you soon!"), serviceId)
                JGGAlertViewController.show(
                    title: LocalizedString("Submission Sent!"),
                    message: message,
                    colorSchema: .green,
                    okButtonTitle: LocalizedString("View Post"),
                    okAction: { text in
                        self.parent?.navigationController?.popToRootViewController(animated: true)
                },
                    cancelButtonTitle: nil,
                    cancelAction: nil
                )
            } else {
                JGGAlertViewController.show(
                    title: LocalizedString("Error!"),
                    message: errorMessage,
                    colorSchema: .red,
                    okButtonTitle: LocalizedString("Close"),
                    okAction: { text in
                        
                },
                    cancelButtonTitle: nil,
                    cancelAction: nil
                )
            }
            self.hud.hide(animated: true)
        })
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
