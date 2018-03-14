//
//  JGGJobSummaryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/29/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import TagListView
import MBProgressHUD

class JGGPostJobSummaryVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var btnDescribe: UIButton!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblJobDescribe: UILabel!
    @IBOutlet weak var tagview: TagListView!
    
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var btnAddress: UIButton!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var btnBudget: UIButton!
    @IBOutlet weak var lblBudget: UILabel!
    
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var lblReport: UILabel!
    
    var creatingJob: JGGJobModel?
    var editingJob: JGGJobModel? {
        set {
            creatingJob = newValue
            isEditMode = true
        }
        get {
            return creatingJob
        }
    }
    fileprivate var isEditMode: Bool = false
    
    private var hud: MBProgressHUD!
    private lazy var imageDownloadURLs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let creatingJob = creatingJob {
            // Describe
            lblJobTitle.text = creatingJob.title
            lblJobDescribe.text = creatingJob.description_
            let tags = creatingJob.tags?.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            if tags != nil { tagview.addTags(tags!) }
            
            // Time
            lblTime.text = creatingJob.jobTimeDescription()
            
            // Address
            lblAddress.text = creatingJob.address?.fullName
            
            // Budget
            var budget: String
            if let fixedAmount = creatingJob.budget {
                budget = String(format: "Fixed $ %.02f", fixedAmount)
            } else if let minAmount = creatingJob.budgetFrom,
                let maxAmount = creatingJob.budgetTo
            {
                budget = String(format: "From $ %.02f to $ %.02f", minAmount, maxAmount)
            } else {
                budget = "No set"
            }
            lblBudget.text = budget
            
            // Report
            lblReport.text = creatingJob.reportTypeName
        } else {
            lblJobTitle.text = LocalizedString("No title")
            lblJobDescribe.text = nil
            tagview.removeAllTags()
            lblTime.text = LocalizedString("No set")
            lblAddress.text = LocalizedString("No set")
            lblBudget.text = LocalizedString("No set")
            lblReport.text = LocalizedString("No set")
        }
        if isEditMode {
            self.btnNext.setTitle(LocalizedString("Save Changes"), for: .normal)
        } else {
            self.btnNext.setTitle(LocalizedString("Post New Job"), for: .normal)
        }
    }

    @IBAction func onPressedStep(_ sender: UIButton) {
        if let stepRootVC = self.navigationController?.viewControllers.first as? JGGPostJobStepRootVC {
            var index: Int = 0
            if sender == btnDescribe {
                index = 0
            }
            else if sender == btnTime {
                index = 1
            }
            else if sender == btnAddress {
                index = 2
            }
            else if sender == btnBudget {
                index = 3
            }
            else if sender == btnReport {
                index = 4
            }
            stepRootVC.stepView.selectStep(index: index)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onPressedPostNewJob(_ sender: UIButton) {
        if let creatingJob = creatingJob {
            hud = MBProgressHUD.showAdded(to: self.parent!.parent!.parent!.view, animated: true)
            
            if self.imageDownloadURLs.count == 0 {
                hud.mode = .annularDeterminate
                hud.label.text = LocalizedString("Uploading photos")
                hud.show(animated: true)
                uploadPhotos(creatingJob.attachmentImages ?? [], index: 0) {
                    self.postJob(creatingJob)
                }
            } else {
                self.postJob(creatingJob)
            }
        }
    }
    
    private func uploadPhotos(_ photos:[UIImage], index: Int, complete: @escaping VoidClosure) {
        if index < photos.count {
            let image = photos[index]
            APIManager.upload(attachmentImage: image, progressClosure: { (percent) in
//                print (index, percent)
                self.hud.progress = (Float(index) + percent) / Float(photos.count)
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
    
    private func postJob(_ creatingJob: JGGJobModel) {
        self.hud.mode = .indeterminate
        
        if !isEditMode {
            
            self.hud.label.text = LocalizedString("Posting Job")

            creatingJob.attachmentUrl = self.imageDownloadURLs
            self.APIManager.postJob(creatingJob, complete: { (jobId, errorMessage) in
                self.hud.hide(animated: true)
                
                if let jobID = jobId {
                    creatingJob.id = jobID
                    let message = String(format: LocalizedString("Job reference no.: %@\n\nGood luck!"), jobID)
                    JGGAlertViewController.show(
                        title: LocalizedString("Job Posted!"),
                        message: message,
                        colorSchema: .cyan,
                        okButtonTitle: LocalizedString("View Job"),
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
                
            })
        } else {
            self.hud.label.text = LocalizedString("Saving Job")
            creatingJob.attachmentUrl = self.imageDownloadURLs
            self.APIManager.editJob(creatingJob, complete: { (jobId, errorMessage) in
                self.hud.hide(animated: true)
                
                if let jobID = jobId {
                    creatingJob.id = jobID
                    let message = String(format: LocalizedString("We will notify the bidding service providers about the changes."), jobID)
                    JGGAlertViewController.show(
                        title: LocalizedString("Changes updated!"),
                        message: message,
                        colorSchema: .cyan,
                        okButtonTitle: LocalizedString("OK"),
                        okAction: { text in
                            self.parent?.navigationController?.popViewController(animated: true)
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
            })
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
