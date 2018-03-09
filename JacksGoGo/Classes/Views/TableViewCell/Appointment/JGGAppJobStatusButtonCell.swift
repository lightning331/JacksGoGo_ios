//
//  JGGAppJobStatusButtonCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppJobStatusButtonCell: JGGAppJobStatusCell {

    @IBOutlet weak var btnViewJob: UIButton!
    
    var buttonTitle: String? {
        set {
            btnViewJob.setTitle(newValue, for: .normal)
        }
        get {
            return btnViewJob.title(for: .normal)
        }
    }
    var buttonAction: VoidClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showLoading() -> Void {
        let text = "Loading..."
        self.lblDescription.attributedText = text.toBold(strings: [text])
        btnViewJob.isEnabled = false
        btnViewJob.alpha = 0.5
    }
    
    func enable() {
        btnViewJob.isEnabled = true
        btnViewJob.alpha = 1.0
    }
    
    @IBAction func onPressButton(_ sender: UIButton) {
        if let buttonAction = buttonAction {
            buttonAction()
        }
    }
    
}
