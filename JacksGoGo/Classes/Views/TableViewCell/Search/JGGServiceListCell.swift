//
//  JGGServiceListCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/11/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos


class JGGServiceListCell: UITableViewCell {

    @IBOutlet weak var imgviewPhoto: UIImageView!
    @IBOutlet weak var imgviewFavorite: UIImageView!
    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblServiceTitle: UILabel!
    @IBOutlet weak var ratebar: CosmosView!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblBookedPeople: UILabel!

    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewRatebar: UIView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewPrice: UIView!
    @IBOutlet weak var viewBooked: UIView!
    
    @IBOutlet weak var imgviewAccessory: UIImageView!
    
    var appointment: JGGJobModel! {
        didSet {
            showAppointmentInfo()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgviewFavorite.isHidden = true
        viewBooked.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    fileprivate func showAppointmentInfo() {
        
        let placeholderAppointment = UIImage(named: "appointment_placeholder")
        imgviewPhoto.image = placeholderAppointment
        if let imageURLString = appointment.attachmentUrl?.first,
            let url = URL(string: imageURLString)
        {
            imgviewPhoto.af_setImage(withURL: url)
        }
        
        imgviewCategory.image = nil
        if let categoryURLString = appointment.category?.image,
            let url = URL(string: categoryURLString) {
            imgviewCategory.af_setImage(withURL: url, placeholderImage: nil)
        }
        
        lblServiceTitle.text = appointment.title
        
        if appointment.isRequest { // Job
            viewRatebar.isHidden = true
            viewTime.isHidden = false
            lblTime.text = appointment.jobTimeDescription()
        } else { // Service
            viewRatebar.isHidden = false
            viewTime.isHidden = true
        }
        lblAddress.text = appointment.address?.fullName
        lblPrice.text = appointment.budgetSimpleDescription()
        
    }
}
