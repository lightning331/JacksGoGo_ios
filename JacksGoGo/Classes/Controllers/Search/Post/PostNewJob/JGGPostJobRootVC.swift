//
//  JGGPostJobRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import AlamofireImage

class JGGPostJobRootVC: JGGSearchBaseVC {

    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    var selectedCategory: JGGCategoryModel!
    var editJob: JGGJobModel? {
        set {
            _editJob = newValue
            if let newValue = newValue {
                selectedCategory = newValue.category!
            }
        }
        get {
            return _editJob
        }
    }
    fileprivate var _editJob: JGGJobModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCategoryName.text = selectedCategory.name
        if selectedCategory.isQuickJob {
            self.imgviewCategory.image = UIImage(named: selectedCategory.image!)
        } else if let urlString = selectedCategory.image, let iconUrl = URL(string: urlString) {
            self.imgviewCategory.af_setImage(withURL: iconUrl)
        }
        if let _ = editJob {
            navigationItem.title = LocalizedString("Edit A Job")
        } else {
            navigationItem.title = LocalizedString("Post A Job")
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @IBAction func onPressedBack(_ sender: Any) {
        var title: String
        let message: String = LocalizedString("All info will be lost.")
        
        if let _ = editJob {
            title = LocalizedString("Quit Editing A Job?")
        } else {
            title = LocalizedString("Quit Posting A New Job?")
        }
        
        JGGAlertViewController.show(title: title,
                                    message: message,
                                    colorSchema: .red,
                                    cancelColorSchema: .cyan,
                                    okButtonTitle: LocalizedString("Quit"),
                                    okAction: { text in
                                        self.navigationController?.popViewController(animated: true)
                                    },
                                    cancelButtonTitle: LocalizedString("Cancel"),
                                    cancelAction: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "gotoPostJobStepRootVC",
            let nav = segue.destination as? JGGPostJobNC,
            let postJobStepRootVC = nav.topViewController as? JGGPostJobStepRootVC
        {
            nav.editJob = editJob
            postJobStepRootVC.selectedCategory = self.selectedCategory
        }
    }

}
