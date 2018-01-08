//
//  JGGServiceCategorySelectCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import AlamofireImage

class JGGSearchCategorySelectCell: UICollectionViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgviewIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgviewTickIcon: UIImageView!
    
    var category: JGGCategoryModel? {
        didSet {
            showCategoryInfo()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                viewContainer.backgroundColor = UIColor.JGGGreen10Percent
            } else {
                viewContainer.backgroundColor = UIColor.JGGWhite
            }
        }
    }
    
    var isVerified: Bool = false {
        didSet {
            if isVerified {
                self.isSelected = false
                self.viewContainer.alpha = 0.5
                self.imgviewTickIcon.isHidden = false
            } else {
                self.viewContainer.alpha = 1.0
                self.imgviewTickIcon.isHidden = true
            }
        }
    }
    
    private func showCategoryInfo() {
        lblTitle.text = category?.name
        if let urlString = category?.image, let url = URL(string: urlString) {
            imgviewIcon.af_setImage(withURL: url)
        }
    }
}
