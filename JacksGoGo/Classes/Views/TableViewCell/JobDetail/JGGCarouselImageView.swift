//
//  JGGCarouselImageView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/3/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGCarouselImageView: TGLParallaxCarouselItem {

    lazy var imageView: UIImageView = UIImageView()
    
    // MARK: - init
    convenience init(frame: CGRect, imageFileName: String) {
        self.init(frame: frame)
        imageView.image = UIImage(named: imageFileName)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setup()
    }
    
    func xibSetup() {
        imageView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        imageView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(imageView)
    }
    
    // MARK: - methods
    fileprivate func setup() {
        layer.masksToBounds = false
        layer.shadowRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.65
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
