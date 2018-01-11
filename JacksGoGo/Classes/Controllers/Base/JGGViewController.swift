//
//  JGGViewController.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MBProgressHUD
import MZFormSheetPresentationController

class JGGViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    
    var APIManager: JGGAPIManager {
        return JGGAPIManager.sharedManager
    }
    
    var appManager: JGGAppManager {
        return JGGAppManager.sharedManager
    }
    
    func updateConstraint(_ animate: Bool = true) -> Void {
        if animate == true {
            self.view.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { (complete) in
                
            })
        } else {
            updateViewConstraints()
        }
    }
    
    func showAlert(title: String?, message: String?) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizedString("OK"), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showHUD(text: String? = nil, to targetView: UIView? = nil) -> Void {
        let hud = MBProgressHUD.showAdded(to: targetView ?? self.view, animated: true)
        if let text = text {
            hud.label.text = text
        }
    }
    
    func hideHUD(from targetView: UIView? = nil) -> Void {
        MBProgressHUD.hide(for: targetView ?? self.view, animated: true)
    }
    
    internal func showPopup(viewController: JGGPopupBaseVC, transitionStyle: MZFormSheetPresentationTransitionStyle = .fade) {
        let mzformSheetVC = MZFormSheetPresentationViewController(contentViewController: viewController)
        mzformSheetVC.contentViewControllerTransitionStyle = transitionStyle
        self.present(mzformSheetVC, animated: true, completion: nil)
    }
}
