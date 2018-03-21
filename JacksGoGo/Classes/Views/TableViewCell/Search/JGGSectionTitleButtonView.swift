//
//  JGGSectionTitleButtonView.swift
//  JacksGoGo
//
//  Created by Chris Lin on 3/21/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSectionTitleButtonView: JGGSectionTitleView {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func startLoading(_ isLoading: Bool = true) -> Void {
        if isLoading {
            loadingIndicator.startAnimating()
            button.isHidden = true
        } else {
            loadingIndicator.stopAnimating()
            button.isHidden = false
        }
    }
    
}
