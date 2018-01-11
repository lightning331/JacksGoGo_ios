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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
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
        let postJobRootVC = serviceStoryboard.instantiateViewController(withIdentifier: "JGGPostJobRootVC") as! JGGPostJobRootVC
        postJobRootVC.selectedCategory = categories[indexPath.row]
        self.navigationController?.pushViewController(postJobRootVC, animated: true)
    }
    
    // MARK: UICollectionViewDelegate

}

class JGGCategoryHeaderDescriptionView: UICollectionReusableView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
}
