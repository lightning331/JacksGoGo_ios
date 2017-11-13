//
//  JGGSelectSkillVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/13/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class JGGSelectSkillVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var viewFirstDescription: UIView!
    @IBOutlet weak var viewSecondDescription: UIView!
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        initCollectionView()
    }

    private func initCollectionView() {
        self.collectionView!.register(UINib(nibName: "JGGSearchCategorySelectCell", bundle: nil),
                                      forCellWithReuseIdentifier: "JGGSearchCategorySelectCell")
        self.collectionView!.register(UINib(nibName: "JGGSelectSkillHeaderView", bundle: nil),
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                      withReuseIdentifier: "header")
        self.collectionView!.register(UINib(nibName: "JGGSelectSkillFooterView", bundle: nil),
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                      withReuseIdentifier: "footer")
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! JGGSelectSkillHeaderView
            headerView.viewFirstDescription.isHidden = true
            return headerView
        } else if kind == UICollectionElementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath) as! JGGSelectSkillFooterView
            return footerView
        } else {
            return UICollectionReusableView()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGSearchCategorySelectCell", for: indexPath) as! JGGSearchCategorySelectCell
        let category = categories[indexPath.row]
        cell.lblTitle.text = category["title"]
        cell.imgviewIcon.image = UIImage(named: category["imageName"]!)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height: CGFloat = 386
        if true {
            height = 88
        }
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 130)
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
