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
            lblMonth.text = appointment.appointmentMonth()?.uppercased()
            lblTitle.text = appointment.title
            
            var desc: String = ""
            if let firstSession = appointment.sessions?.first,
                let startTime = firstSession.startOn
            {
                desc = "Need on" + startTime.toString(format: .custom("d MMM, yyyy"))
            } else {
                desc = appointment.description_ ?? ""
            }
            lblDescription.text = desc
            
            setBadge(0)
            
            let avatarPlaceholder = UIImage(named: "icon_profile")
            imgviewAvatar.image = avatarPlaceholder
            if let urlString = appointment.userProfile?.user.photoURL,
                let url = URL(string: urlString) {
                imgviewAvatar.af_setImage(withURL: url, placeholderImage: avatarPlaceholder)
            } else {
                imgviewAvatar.image = avatarPlaceholder
            }
            
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
    
    private func setBadge(_ badge: Int) {
        if badge > 0 {
            lblCountBadge.text = String(badge)
            lblCountBadge.isHidden = false
            viewCountBadge.isHidden = false
            viewRightSideBadge.isHidden = false
        } else {
            lblCountBadge.isHidden = true
            viewCountBadge.isHidden = true
            viewRightSideBadge.isHidden = true
        }
    }
}
