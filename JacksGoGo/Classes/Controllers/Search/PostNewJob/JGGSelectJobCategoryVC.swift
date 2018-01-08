//
//  JGGSelectJobCategoryVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSelectJobCategoryVC: UICollectionViewController {

    fileprivate lazy var categories: [JGGCategoryModel] = []
    
    private var loadingIndicatorView: UIActivityIndicatorView?
    private var isLoadingCategories: Bool = false
    
    /*
    fileprivate lazy var categories: [[String: String]] = [
        [
            "title": LocalizedString("Favourited Services"),
            "imageName": "icon_cat_favourites",
            ],
        [
            "title": LocalizedString("Cooking & Baking"),
            "imageName": "icon_cat_cooking&baking",
            ],
        [
            "title": LocalizedString("Education"),
            "imageName": "icon_cat_education",
            ],
        [
            "title": LocalizedString("Handyman"),
            "imageName": "icon_cat_handyman",
            ],
        [
            "title": LocalizedString("Household Chores"),
            "imageName": "icon_cat_householdchores",
            ],
        [
            "title": LocalizedString("Messenger"),
            "imageName": "icon_cat_messenger",
            ],
        [
            "title": LocalizedString("Running Man"),
            "imageName": "icon_cat_runningman",
            ],
        [
            "title": LocalizedString("Leisure"),
            "imageName": "icon_cat_leisure",
            ],
        [
            "title": LocalizedString("Social"),
            "imageName": "icon_cat_social",
            ],
        [
            "title": LocalizedString("Sports"),
            "imageName": "icon_cat_runningman",
            ],
        [
            "title": LocalizedString("Event"),
            "imageName": "icon_cat_event",
            ],
        [
            "title": LocalizedString("Exploration"),
            "imageName": "icon_cat_exploration",
            ],
        [
            "title": LocalizedString("Family"),
            "imageName": "icon_cat_family",
            ],
        [
            "title": LocalizedString("Gardening"),
            "imageName": "icon_cat_gardening",
            ],
        ]
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "JGGSearchCategorySelectCell", bundle: nil),
                                      forCellWithReuseIdentifier: "JGGSearchCategorySelectCell")

        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        loadCategories()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.JGGCyan
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.JGGCyan]
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedStringKey.foregroundColor: UIColor.JGGCyan]
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = LocalizedString("Post A Job")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = " "
    }
    
    private func loadCategories() {
        
        func reloadCategories() {
            self.categories = appManager.categories
            self.collectionView?.reloadData()
            loadingIndicatorView?.stopAnimating()
        }
        
        if appManager.categories.count == 0 {
            isLoadingCategories = true
            loadingIndicatorView?.startAnimating()
            APIManager.getCategories { (result) in
                self.isLoadingCategories = false
                self.appManager.categories = result
                reloadCategories()
            }
        } else {
            reloadCategories()
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "descriptionHeader", for: indexPath) as! JGGCategoryHeaderDescriptionView
        if isLoadingCategories {
            headerView.loadingIndicatorView.startAnimating()
        } else {
            headerView.loadingIndicatorView.stopAnimating()
        }
        return headerView
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGSearchCategorySelectCell",
                                                      for: indexPath) as! JGGSearchCategorySelectCell

        let category = categories[indexPath.row]
        cell.category = category
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let serviceStoryboard = UIStoryboard(name: "Services", bundle: nil)
        let postJobRootStepVC = serviceStoryboard.instantiateViewController(withIdentifier: "JGGPostJobRootVC") as! JGGPostJobRootVC
        self.navigationController?.pushViewController(postJobRootStepVC, animated: true)
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

class JGGCategoryHeaderDescriptionView: UICollectionReusableView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    
}
