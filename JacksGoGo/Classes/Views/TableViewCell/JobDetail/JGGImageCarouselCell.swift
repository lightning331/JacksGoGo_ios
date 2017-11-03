//
//  JGGImageCarouselCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGImageCarouselCell: UITableViewCell {

    @IBOutlet weak var carouselView: TGLParallaxCarousel!
    @IBOutlet weak var imgviewJobSummary: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        carouselView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
