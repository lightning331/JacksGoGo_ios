//
//  JGGAppSearchHeaderView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppSearchHeaderView: UIView {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for subview in searchBar.subviews {
            for view in subview.subviews {
                if let textfield = view as? UITextField {
                    textfield.font = UIFont.JGGListText
                }
            }
        }
        
    }

}
