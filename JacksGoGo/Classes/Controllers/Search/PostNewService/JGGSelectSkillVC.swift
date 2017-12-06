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
    
    var isShowAllSkills: Bool = false
    var verifiedSkills: [JGGCategoryModel] = []
    
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

    private var headerType: Int = 1 // 0 : no verified skills of user,
                                    // 1 : some verfied skill,
                                    // 2 : show all categories
    
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initCollectionView()
        
        initUI()
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
    
    private func initUI() {
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if isShowAllSkills == false && verifiedSkills.count == 0 {
            //  No verified Skills of user
            headerType = 0
            self.navigationItem.title = LocalizedString("Post A Service")
        } else if isShowAllSkills == false && verifiedSkills.count > 0 {
            // There are some verified skills of user
            headerType = 1
            self.navigationItem.title = LocalizedString("Post A Service")
        } else {
            // Show All categories
            headerType = 2
            self.navigationItem.title = LocalizedString("Verify New Skills")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if headerType == 0 || headerType == 1 {
            self.navigationItem.title = LocalizedString("Post A Service")
        } else {
            self.navigationItem.title = LocalizedString("Verify New Skills")
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = " "
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        var height: CGFloat = 386
        if headerType == 0 {
            height = 386
        } else if headerType == 1 {
            height = 88
        } else if headerType == 2 {
            height = 155
        }
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        if headerType == 1 {
            return CGSize(width: collectionView.frame.width, height: 130)
        } else {
            return CGSize.zero
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             withReuseIdentifier: "header",
                                                                             for: indexPath) as! JGGSelectSkillHeaderView
            if      headerType == 0 { headerView.viewFirstDescription.isHidden = false }
            else if headerType == 1 { headerView.viewSecondDescription.isHidden = false }
            else if headerType == 2 { headerView.viewThirdDescription.isHidden = false }
            
            return headerView
        } else if kind == UICollectionElementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                                             withReuseIdentifier: "footer",
                                                                             for: indexPath) as! JGGSelectSkillFooterView
            footerView.btnVerifyNewSkill.addTarget(self,
                                                   action: #selector(onPressedVerifyNewSkill(_:)),
                                                   for: .touchUpInside)
            return footerView
        } else {
            return UICollectionReusableView()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if headerType == 1 {
            return verifiedSkills.count
        } else {
            return categories.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGSearchCategorySelectCell",
                                                      for: indexPath) as! JGGSearchCategorySelectCell
        if headerType == 1 {
            let category = categories[indexPath.row]
            cell.lblTitle.text = category["title"]
            cell.imgviewIcon.image = UIImage(named: category["imageName"]!)
        } else {
            let category = categories[indexPath.row]
            cell.lblTitle.text = category["title"]
            cell.imgviewIcon.image = UIImage(named: category["imageName"]!)
            if headerType == 2 {
                let title = category["title"]
                if title == "Messenger" || title == "Running Man" {
                    cell.isVerified = true
                } else {
                    cell.isVerified = false
                }
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var canVerifySkill = true
        if headerType == 0 {
            
        } else if headerType == 1 {
            canVerifySkill = false
        } else if headerType == 2 {
            let cell = collectionView.cellForItem(at: indexPath) as! JGGSearchCategorySelectCell
            if cell.isVerified { canVerifySkill = false }
        }
        if canVerifySkill {
            let serviceStoryboard = UIStoryboard(name: "Services", bundle: nil)
            let skillTestVC = serviceStoryboard.instantiateViewController(withIdentifier: "JGGSkillTestVC") as! JGGSkillTestVC
            self.navigationController?.pushViewController(skillTestVC, animated: true)
        } else {
            onPressedSkill(self)

        }
    }

    // MARK: - Actions
    
    @objc fileprivate func onPressedVerifyNewSkill(_ sender: Any) {
        let verifySkillVC =
            self.storyboard?
                .instantiateViewController(withIdentifier: "JGGSelectSkillVC") as! JGGSelectSkillVC
        self.navigationController?.pushViewController(verifySkillVC, animated: true)
    }
    
    @objc fileprivate func onPressedSkill(_ sender: Any) {
        self.performSegue(withIdentifier: "gotoPostService", sender: self)
    }
    
}
