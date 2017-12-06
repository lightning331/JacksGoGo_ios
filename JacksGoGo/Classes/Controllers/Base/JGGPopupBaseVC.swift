//
//  JGGPopupBaseVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import MZFormSheetPresentationController

class JGGPopupBaseVC: JGGViewController, MZFormSheetPresentationContentSizing {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shouldUseContentViewFrame(for presentationController: MZFormSheetPresentationController!) -> Bool {
        return true
    }
    
    func contentViewFrame(for presentationController: MZFormSheetPresentationController!, currentFrame: CGRect) -> CGRect {
        return currentFrame
    }

}
