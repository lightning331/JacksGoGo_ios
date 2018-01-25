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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblCategoryName.text = selectedCategory.name
        if selectedCategory.isQuickJob {
            self.imgviewCategory.image = UIImage(named: selectedCategory.image!)
        } else if let urlString = selectedCategory.image, let iconUrl = URL(string: urlString) {
            self.imgviewCategory.af_setImage(withURL: iconUrl)
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @IBAction func onPressedBack(_ sender: Any) {
        JGGAlertViewController.show(title: LocalizedString("Quit Posting A New Job?"),
                                    message: LocalizedString("All info will be lost."),
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
            let nav = segue.destination as? UINavigationController,
            let postJobStepRootVC = nav.topViewController as? JGGPostJobStepRootVC
        {
            postJobStepRootVC.selectedCategory = self.selectedCategory
        }
    }

}
