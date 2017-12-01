//
//  JGGPhotoCropVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/1/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import IGRPhotoTweaks

class JGGPhotoCropVC: IGRPhotoTweakViewController {

    @IBOutlet weak var imgviewBackground: UIImageView!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnCrop: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    lazy var effectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: effect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.sendSubview(toBack: self.imgviewBackground)
        effectView.frame = view.frame
        self.view.insertSubview(effectView, aboveSubview: imgviewBackground)
        imgviewBackground.image = self.image
    }

    @IBAction func onPressedClose(_ sender: Any) {
        self.dismissAction()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressedReset(_ sender: Any) {
        self.resetView()
    }
    
    @IBAction func onPressedCrop(_ sender: Any) {
        self.cropAction()
        self.dismiss(animated: true, completion: nil)
    }
}
