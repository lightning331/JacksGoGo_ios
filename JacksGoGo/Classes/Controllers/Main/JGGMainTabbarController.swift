//
//  JGGMainTabbarController.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import SnapKit

class JGGMainTabbarController: UITabBarController {

    fileprivate var loadingView: JGGSplashLoadingView?
    fileprivate let totalLoadingCount: Float = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        
        self.showLoadingIndicator()
        
        loadRegions()
        
        
    }
    
    private func autoAuthorize() {
        let loginCompletion: UserProfileModelResponse = { (userProfile, errorMessage) in
            self.loadingView?.progressbar.setProgress(3 / self.totalLoadingCount, animated: true)
            if let userProfile = userProfile {
                self.appManager.currentUser = userProfile
            }
            self.hideLoadingIndicator()
            self.addViewControllers()
        }
        
        let usernamePassword = appManager.getUsernamePassword()
        if let username = usernamePassword.0, let password = usernamePassword.1 {
            self.loadingView?.loadingDescription.text = LocalizedString("Loading user information...")
            if appManager.isAuthorized {
                self.APIManager.accountLogin(email: username, password: password, complete: loginCompletion)
            } else {
                APIManager.oauthToken(user: username, password: password, complete: { (success, errorString) in
                    if success {
                        self.APIManager.accountLogin(email: username, password: password, complete: loginCompletion)
                    } else {
                        self.hideLoadingIndicator()
                        self.addViewControllers()
                    }
                })
            }
        } else {
            self.hideLoadingIndicator()
            self.addViewControllers()
        }
    }
    
    private func loadRegions() {
        self.loadingView?.loadingDescription.text = LocalizedString("Loading regions...")
        APIManager.getRegions { (result) in
            self.appManager.regions = result
            self.loadingView?.progressbar.setProgress(1 / self.totalLoadingCount, animated: true)
            self.getCategories()
        }
    }
    
    private func getCategories() {
        self.loadingView?.loadingDescription.text = LocalizedString("Loading categories...")
        APIManager.getCategories { (result) in
            self.appManager.categories = result
            self.loadingView?.progressbar.setProgress(2 / self.totalLoadingCount, animated: true)
            self.autoAuthorize()
        }
    }
    
    private func showLoadingIndicator() {
        
        if let loadingView = UINib(nibName: "JGGSplashLoadingView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? JGGSplashLoadingView {
            self.view.addSubview(loadingView)
            loadingView.snp.makeConstraints { (maker) in
                maker.left.top.right.bottom.equalToSuperview()
            }
            self.loadingView = loadingView
            self.loadingView?.progressbar.progress = 0
        }
        
    }
    
    private func hideLoadingIndicator() {
        loadingView?.removeFromSuperview()
    }
    
    private func loadViewControllers() {
        if self.viewControllers == nil || self.viewControllers?.count == 0 {
            
            func addChildViewController(storyboardName: String) {
                let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
                if let initialVC = storyboard.instantiateInitialViewController() {
                    self.addChildViewController(initialVC)
                }
            }
            addChildViewController(storyboardName: "Home")
            addChildViewController(storyboardName: "Services")
            addChildViewController(storyboardName: "Appointment")
            addChildViewController(storyboardName: "Favorite")
            addChildViewController(storyboardName: "Profile")
            
            self.selectedIndex = 1
        }
    }
    
    private func addViewControllers() {
        func initialViewController(of storyboardName: String) -> UIViewController {
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            if let initialVC = storyboard.instantiateInitialViewController() {
                return initialVC
            } else {
                return UINavigationController(rootViewController: UIViewController())
            }
        }
        
        self.viewControllers = [
            initialViewController(of: "Home"),
            initialViewController(of: "Services"),
            initialViewController(of: "Appointment"),
            initialViewController(of: "Favorite"),
            initialViewController(of: "Profile"),
        ]
        
        self.selectedIndex = 1
    }
    
}
