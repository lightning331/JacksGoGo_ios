//
//  JGGPostServiceRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceRootVC: JGGSearchBaseVC {

    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var viewContainer: UIView!

    var selectedCategory: JGGCategoryModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lblCategoryName.text = selectedCategory.name
        if let urlString = selectedCategory.image, let iconUrl = URL(string: urlString) {
            self.imgviewCategory.af_setImage(withURL: iconUrl)
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func addTodayButton() -> Void {
        let btnToday = UIBarButtonItem(image: UIImage(named: "button_today_green"), style: .plain, target: self, action: #selector(onPressedToday(_:)))
        self.navigationItem.rightBarButtonItem = btnToday
    }
    
    func removeTodayButton() -> Void {
        self.navigationItem.rightBarButtonItem = nil
    }

    @objc func onPressedToday(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: JGGNotificationShowToday), object: nil)
    }
    
    @IBAction func onPressedBack(_ sender: Any) {
        JGGAlertViewController.show(
            title: LocalizedString("Quit Posting A New Service?"),
            message: LocalizedString("All info will be lost."),
            colorSchema: .red,
            cancelColorSchema: .green,
            okButtonTitle: LocalizedString("Quit"),
            okAction: { text in
                self.navigationController?.popViewController(animated: true)
            },
            cancelButtonTitle: LocalizedString("Cancel"),
            cancelAction: nil
        )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "gotoPostServiceStepRootVC",
            let nav = segue.destination as? UINavigationController,
            let postJobStepRootVC = nav.topViewController as? JGGPostServiceStepRootVC
        {
            postJobStepRootVC.selectedCategory = self.selectedCategory
        }
    }

}
