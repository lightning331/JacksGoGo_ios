//
//  JGGServiceCategorySelectCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSearchCategorySelectCell: UICollectionViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imgviewIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
}
