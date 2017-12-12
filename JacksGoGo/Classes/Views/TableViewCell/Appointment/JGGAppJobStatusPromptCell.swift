//
//  JGGAppJobStatusPromptCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppJobStatusPromptCell: JGGAppJobStatusCell {

    @IBOutlet weak var viewPromptContent: UIView!
    @IBOutlet weak var lblPromptTitle: UILabel!
    @IBOutlet weak var lblPromptContent: UILabel!
    @IBOutlet weak var lblPromptPrice: UILabel!
    @IBOutlet weak var btnPromptDeny: UIButton!
    @IBOutlet weak var btnPromptApprove: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prompt(content: String?, price: Float) -> Void {
        lblPromptTitle.text = LocalizedString("Billable Item: Approval Required")
        lblPromptContent.text = content
        lblPromptPrice.text = String(format: "$ %.02f", price)
    }
    
}
