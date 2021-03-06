//
//  JGGAppInviteProviderCell.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/2/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppInviteProviderCell: JGGUserAvatarNameRateCell {

    @IBOutlet weak var btnInvite: UIButton!
    
    var buttonAction: VoidClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func invitedMode() -> Void {
        self.btnInvite.setTitle(nil, for: .normal)
        self.btnInvite.setImage(UIImage(named: "icon_chat_green"), for: .normal)
        self.btnInvite.tintColor = UIColor.JGGGreen
    }
    
    func setNewProvider(_ isNewProvider: Bool) -> Void {
        if isNewProvider {
            self.viewBackground.backgroundColor = UIColor.JGGGreen10Percent
        } else {
            self.viewBackground.backgroundColor = UIColor.JGGWhite
        }
    }
    
    @IBAction func onPressedButton(_ sender: UIButton) {
        buttonAction?()
    }
    
    func disableInviteButton(_ disable: Bool = true) -> Void {
        btnInvite.isEnabled = !disable
        btnInvite.alpha = disable ? 0.3 : 1.0
        if disable {
            btnInvite.setTitleColor(UIColor.JGGGrey3, for: .normal)
        } else {
            btnInvite.setTitleColor(UIColor.JGGGreen, for: .normal)
        }
    }
    
}
