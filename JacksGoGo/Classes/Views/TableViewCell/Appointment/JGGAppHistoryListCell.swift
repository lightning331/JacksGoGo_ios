//
//  JGGAppHistoryListCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppHistoryListCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var viewRightSideBadge: UIView!
    @IBOutlet weak var imgviewAvatar: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewCountBadge: UIView!
    @IBOutlet weak var lblCountBadge: UILabel!
    
    var job: JGGJobModel? {
        didSet {
            updateValue()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    fileprivate func updateValue() {
        if let appointment = job {
            lblDay.text = appointment.appointmentDay()
            lblMonth.text = appointment.appointmentMonth()
            lblTitle.text = appointment.title
            lblDescription.text = appointment.description_
            lblCountBadge.text = String(3)
            viewCountBadge.isHidden = 3 == 0
            viewRightSideBadge.isHidden = 3 == 0
            
//            if let urlString = appointment.attachmentUrl?.first, let url = URL(string: urlString) {
            
//            }
            
            var color = UIColor.JGGCyan
            if appointment.isRequest == false {
                color = UIColor.JGGGreen
            }
            lblDay.textColor = color
            lblMonth.textColor = color
            
            lblStatus.isHidden = true
        }
    }
}
