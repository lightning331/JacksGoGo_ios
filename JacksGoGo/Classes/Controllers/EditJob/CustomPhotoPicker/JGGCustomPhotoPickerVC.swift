//
//  CustomPhotoPickerViewController.swift
//  TLPhotoPicker
//
//  Created by Hemin Wang on 12/1/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import Foundation
import TLPhotoPicker

class JGGCustomPhotoPickerVC: TLPhotosPickerViewController {
    
    override func makeUI() {
        
        var configure = TLPhotosPickerConfigure()
        configure.maxSelectedAssets = 10
        configure.allowedLivePhotos = false
        configure.allowedVideo = false
        configure.allowedVideoRecording = false
        configure.autoPlay = false
//        configure.cameraCellNibSet = (nibName: "JGGPhotoPickerCameraCell", bundle: Bundle.main)
        configure.selectedColor = UIColor.JGGGreen
        configure.cameraIcon = UIImage(named: "icon_take_photo_green")
        configure.cameraBgColor = UIColor.JGGGrey5
        
//        configure.nibSet = (nibName: "JGGPhotoPickerCustomCell", bundle: Bundle.main)
        self.configure = configure

        super.makeUI()
        self.customNavItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop,
                                                               target: nil,
                                                               action: #selector(customAction))
        self.customNavItem.leftBarButtonItem?.tintColor = UIColor.JGGGreen
        
        self.customNavItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "button_tick_green"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(doneButtonTap))
        self.customNavItem.rightBarButtonItem?.tintColor = UIColor.JGGGreen
        self.navigationController?.navigationBar.tintColor = UIColor.JGGGreen
    }
    
    @objc func customAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
