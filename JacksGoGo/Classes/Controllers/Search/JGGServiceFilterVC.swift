//
//  JGGServiceFilterVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/20/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGServiceFilterVC: JGGSearchBaseVC {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var txtServiceKeyword: UITextField!
    @IBOutlet weak var txtLocationName: UITextField!
    @IBOutlet weak var btnCurrentLocation: UIButton!
    @IBOutlet weak var clsviewAllCategories: UICollectionView!

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
        [
            "title": LocalizedString("Other Professions"),
            "imageName": "icon_cat_other",
            ],
        ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    private func initCollectionView() {
        self.clsviewAllCategories.register(UINib(nibName: "JGGSearchCategorySelectCell", bundle: nil),
                                           forCellWithReuseIdentifier: "JGGSearchCategorySelectCell")
        self.clsviewAllCategories.dataSource = self
        self.clsviewAllCategories.delegate = self
        self.clsviewAllCategories.allowsMultipleSelection = true
        
    }

    @IBAction func onPressedClose(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func onPressedCurrentLocation(_ sender: Any) {
        
    }

}

extension JGGServiceFilterVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGSearchCategorySelectCell", for: indexPath) as! JGGSearchCategorySelectCell
        let category = categories[indexPath.row]
        cell.lblTitle.text = category["title"]
        cell.imgviewIcon.image = UIImage(named: category["imageName"]!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = self.view.bounds.width
        if viewWidth == 375 {
            return CGSize(width: (viewWidth - 62) / 4, height: 105)
        } else {
            return CGSize(width: 88, height: 105)
        }
    }
}
