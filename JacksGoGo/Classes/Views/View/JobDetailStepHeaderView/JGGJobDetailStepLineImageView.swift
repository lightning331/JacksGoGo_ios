//
//  JGGJobDetailStepLineImageView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGJobDetailStepLineImageView: UIImageView {

    func setCompletion(_ isCompletion: Bool = true) -> Void {
        if isCompletion {
            self.image = UIImage(named: "line_full")
        } else {
            self.image = UIImage(named: "line_dotted")
        }
    }

}
