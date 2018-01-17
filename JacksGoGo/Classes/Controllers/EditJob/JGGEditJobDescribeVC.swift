//
//  JGGEditJobDescribeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import TLPhotoPicker

class JGGEditJobDescribeVC: JGGEditJobBaseTableVC {

    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var txtJobDescribe: UITextView!
    @IBOutlet weak var collectionPhotos: UICollectionView!
    @IBOutlet weak var btnTakePhotos: UIButton!
    @IBOutlet weak var iconTakePhoto: UIImageView!
    
    fileprivate var selectedImages: [TLPHAsset] = []
    var originalImages: [URL] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    private func initUI() {
        
        collectionPhotos.register(UINib(nibName: "JGGPictureCell", bundle: nil),
                                  forCellWithReuseIdentifier: "JGGPictureCell")
        collectionPhotos.dataSource = self
        collectionPhotos.delegate = self
        
        collectionPhotos.isHidden = true
        btnTakePhotos.isHidden = false
        iconTakePhoto.isHidden = false
    }

    @IBAction func onPressedTakePhoto(_ sender: Any) {
        
        let photoPicker = JGGCustomPhotoPickerVC()
        photoPicker.delegate = self
        photoPicker.selectedAssets = self.selectedImages
        photoPicker.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            self?.showAlert(title: LocalizedString("Warning"),
                            message: LocalizedString("Exceed Maximum Number Of Selection"))
        }

        present(photoPicker, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            var imageCount = selectedImages.count
            if imageCount == 0 {
                return 80
            } else {
                imageCount += 1
                let floatRow: Float = Float(imageCount) / 4.0
                var intRow: Int = Int(imageCount / 4)
                if floatRow > Float(intRow) { intRow += 1 }
                
                let photoCellSize = (collectionPhotos.frame.width - 30) / 4
                let rowHeight = photoCellSize * CGFloat(intRow) + (CGFloat(intRow) - 1) * 10
                return rowHeight + 25
            }
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

}

extension JGGEditJobDescribeVC: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        self.selectedImages = withTLPHAssets
        if withTLPHAssets.count > 0 {
            collectionPhotos.isHidden = false
            btnTakePhotos.isHidden = true
            iconTakePhoto.isHidden = true
        } else {
            collectionPhotos.isHidden = true
            btnTakePhotos.isHidden = false
            iconTakePhoto.isHidden = false
        }
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        collectionPhotos.reloadData()
    }
}

extension JGGEditJobDescribeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGPictureCell", for: indexPath) as! JGGPictureCell
        if indexPath.row < selectedImages.count {
            cell.imageView.image = selectedImages[indexPath.row].fullResolutionImage
        } else {
            cell.imageView.image = UIImage(named: "icon_add_photo_green")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < selectedImages.count {
            let images =
                self.selectedImages
                    .filter { $0.fullResolutionImage != nil }
                    .map { LightboxImage(image: $0.fullResolutionImage!, text: "") }
            
            LightboxConfig.CloseButton.image = UIImage(named: "button_close_round_green")
            LightboxConfig.CloseButton.text = ""
            let controller = LightboxController(images: images, startIndex: indexPath.row)
            
            controller.pageDelegate = self
            controller.dismissalDelegate = self
            controller.dynamicBackground = true
            
            present(controller, animated: true, completion: nil)
        } else {
            self.onPressedTakePhoto(self.btnTakePhotos)
        }
    }
}

extension JGGEditJobDescribeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 30) / 4
        return CGSize(width: size, height: size)
    }
}

extension JGGEditJobDescribeVC: LightboxControllerPageDelegate, LightboxControllerDismissalDelegate {
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        
    }
    
    func lightboxController(_ controller: LightboxController, didChange image: UIImage?, of page: Int) {
        
    }
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        
    }
}
