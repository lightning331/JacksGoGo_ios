//
//  JGGPostJobDescribeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/28/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostJobDescribeVC: JGGPostServiceDescribeVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func updateData(_ sender: Any) {
        self.view.endEditing(true)
        if let parentVC = parent as? JGGPostJobStepRootVC {
            let creatingJob: JGGJobModel?
            if parentVC.editingJob != nil {
                creatingJob = parentVC.editingJob
            } else {
                creatingJob = parentVC.creatingJob
            }
            creatingJob?.title = txtServiceTitle.text
            creatingJob?.description_ = txtServiceDescribe.text
            creatingJob?.tags = txtTags.text
            
            var images: [UIImage] = []
            let localImages: [UIImage]
                = selectedImages?.filter { $0.1 != nil }.map { $0.1! } ?? []
            let urlImages: [UIImage]
                = originalImages?.filter { $0.1 != nil }.map { $0.1! } ?? []
            images.append(contentsOf: localImages)
            images.append(contentsOf: urlImages)
            
            creatingJob?.attachmentImages = images
            if let originalImages = originalImages {
                creatingJob?.attachmentUrl =
                    originalImages
                        .filter { $0.0 != nil }
                        .map { $0.0!.absoluteString }
            }
                
        }
    }
}
