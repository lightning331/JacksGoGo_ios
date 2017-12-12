//
//  JGGAppJobStatusCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

public enum JGGJobStatusCellType {
    case posted,
         watingProvider,
         appointment,
         time,
         verified,
         none,
         cost,
         information
}

class JGGAppJobStatusCell: UITableViewCell {

    @IBOutlet weak var imgviewStatus: UIImageView!
    @IBOutlet weak var viewFlowLine: UIView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var constraintIconHeight: NSLayoutConstraint!
    
    var cellType: JGGJobStatusCellType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showDotLine()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func showDotLine(_ isDotLine: Bool = true) -> Void {
        if isDotLine {
            
            viewFlowLine.backgroundColor = UIColor.clear
            
            let  path = UIBezierPath()
            
            let  p0 = CGPoint(x: viewFlowLine.bounds.midX, y: viewFlowLine.bounds.minY)
            path.move(to: p0)
            
            let  p1 = CGPoint(x: viewFlowLine.bounds.midX, y: viewFlowLine.bounds.maxY)
            path.addLine(to: p1)
            
            let dotLineLayer = CAShapeLayer()
            dotLineLayer.path = path.cgPath
            dotLineLayer.lineWidth = 2.0
            dotLineLayer.lineDashPhase = 0.0
            dotLineLayer.lineDashPattern = [ 0.0, 8.0 ]
            dotLineLayer.lineCap = "round"
            dotLineLayer.strokeColor = UIColor.JGGGrey3.cgColor
            viewFlowLine.layer.addSublayer(dotLineLayer)
            
        } else {
            
            if let lineLayers = viewFlowLine.layer.sublayers {
                for sl in lineLayers {
                    sl.removeAllAnimations()
                    sl.removeFromSuperlayer()
                }
            }
            
            viewFlowLine.backgroundColor = UIColor.JGGGreen
            
        }
    }
    
    func statusIcon(hide: Bool) -> Void {
        if imgviewStatus.isHidden != hide {
            imgviewStatus.isHidden = hide
            if hide {
                constraintIconHeight.constant = 0
                updateConstraints()
            } else {
                constraintIconHeight.constant = 24
                updateConstraints()
            }
        }
    }
    
    func setType(_ type: JGGJobStatusCellType, time: Date?, isActive: Bool, text: String?, boldStrings: [String]?) -> Void {
        self.cellType = type
        let iconName: String?
        switch type {
        case .posted:
            iconName = isActive ? "icon_posted" : "icon_posted_inactive"
            break
        case .watingProvider:
            iconName = isActive ? "icon_provider" : "icon_provider_inactive"
            break
        case .appointment:
            iconName = isActive ? "icon_appointment" : "icon_appointment_inactive"
            break
        case .time:
            iconName = isActive ? "icon_startwork" : "icon_startwork_inactive"
            break
        case .verified:
            iconName = "icon_verified"
            break
        case .none:
            iconName = nil
            break
        case .cost:
            iconName = "icon_budget"
            break
        case .information:
            iconName = "icon_info"
            break
        }
        self.viewFlowLine.isHidden = (type == .posted)
        if let iconFileName = iconName {
            self.imgviewStatus.image = UIImage(named: iconFileName)
            statusIcon(hide: false)
        } else {
            statusIcon(hide: true)
        }
        if isActive {
            showDotLine(false)
        } else {
            showDotLine()
        }
        if let time = time {
            self.lblTime.text = DateTimeString(from: time)
        } else {
            self.lblTime.text = nil
        }
        if let boldStrings = boldStrings {
            self.lblDescription.attributedText = text?.toBold(strings: boldStrings)
        } else {
            self.lblDescription.text = text
        }
        
    }

}
