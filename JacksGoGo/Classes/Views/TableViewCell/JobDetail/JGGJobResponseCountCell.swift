//
//  JGGJobResponseCountCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/15/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGJobResponseCountCell: UITableViewCell {

    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var lblResponses: UILabel!
    @IBOutlet weak var lblLatestResponseTime: UILabel!
    @IBOutlet weak var lblAverageQuoteValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
