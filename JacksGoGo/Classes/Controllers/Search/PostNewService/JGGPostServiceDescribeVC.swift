//
//  JGGPostServiceDescribeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Toaster

class JGGPostServiceDescribeVC: JGGPostAppointmentBaseTableVC {

    @IBOutlet weak var lblServiceTitle: UILabel!
    @IBOutlet weak var txtServiceTitle: UITextField!
    @IBOutlet weak var lblServiceDescribe: UILabel!
    @IBOutlet weak var txtServiceDescribe: UITextView!
    @IBOutlet weak var txtTags: UITextField!
    @IBOutlet weak var collectionPhotos: UICollectionView!
    @IBOutlet weak var btnTakePhotos: UIButton!
    @IBOutlet weak var iconTakePhoto: UIImageView!
    
    internal var selectedImages: [(TLPHAsset, UIImage?)] = []
    var originalImages: [URL] = []
    
    private var isChangedImage: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        if SHOW_TEMP_DATA {
            showTemporaryData()
        }
    }
    
    private func showTemporaryData() {
        txtServiceTitle.text = "Test"
        txtServiceDescribe.text = "Temporary description"
        txtTags.text = "cooking, meats"
    }
    

    private func initUI() {
        
        collectionPhotos.register(UINib(nibName: "JGGPictureCell", bundle: nil),
                                  forCellWithReuseIdentifier: "JGGPictureCell")
        collectionPhotos.dataSource = self
        collectionPhotos.delegate = self
        
        collectionPhotos.isHidden = true
        btnTakePhotos.isHidden = false
        iconTakePhoto.isHidden = false
        
        txtServiceTitle.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
        txtServiceTitle.delegate = self
        txtServiceDescribe.delegate = self
        
    }
    
    @IBAction func onPressedTakePhoto(_ sender: Any) {
        
        let photoPicker = JGGCustomPhotoPickerVC()
        photoPicker.delegate = self
        photoPicker.selectedAssets = self.selectedImages.flatMap { $0.0 }
        photoPicker.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            self?.showAlert(title: LocalizedString("Warning"),
                            message: LocalizedString("Exceed Maximum Number Of Selection"))
        }
        
        present(photoPicker, animated: true, completion: nil)
    }
    
    override func onPressedNext(_ sender: UIButton) {
        if checkRequiredFields() {
            super.onPressedNext(sender)
        } else {
            Toast(text: LocalizedString("Input all required fields."), delay: 0, duration: 3).show()
        }
    }
    
    private func checkRequiredFields() -> Bool {
        var isAvailable = true
        if let title = txtServiceTitle.text, title.count == 0 {
            isAvailable = false
            txtServiceTitle.superview?.borderColor = UIColor.JGGRed
            lblServiceTitle.textColor = UIColor.JGGRed
        }
        if txtServiceDescribe.text.count == 0 {
            isAvailable = false
            txtServiceDescribe.superview?.borderColor = UIColor.JGGRed
            lblServiceDescribe.textColor = UIColor.JGGRed
        }
        return isAvailable
    }
    
    // MARK: - Table view data source
       
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
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

extension JGGPostServiceDescribeVC: UITextFieldDelegate, UITextViewDelegate {
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        textField.superview?.borderColor = UIColor.JGGGrey3
        if textField == txtServiceTitle {
            lblServiceTitle.textColor = UIColor.JGGBlack
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.superview?.borderColor = UIColor.JGGGrey3
        if textView == txtServiceDescribe {
            lblServiceDescribe.textColor = UIColor.JGGBlack
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtServiceTitle {
            txtServiceDescribe.becomeFirstResponder()
        }
        return true
    }
    
}

extension JGGPostServiceDescribeVC: TLPhotosPickerViewControllerDelegate {
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        self.selectedImages = withTLPHAssets.flatMap { ($0, $0.fullResolutionImage) }
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

extension JGGPostServiceDescribeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JGGPictureCell", for: indexPath) as! JGGPictureCell
        if indexPath.row < selectedImages.count {
            cell.imageView.image = selectedImages[indexPath.row].1
        } else {
            cell.imageView.image = UIImage(named: "icon_add_photo_green")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < selectedImages.count {
            let images =
                self.selectedImages
                    .filter { $0.1 != nil }
                    .map { LightboxImage(image: $0.1!, text: "") }
            
            LightboxConfig.CloseButton.image = UIImage(named: "button_close_round_green")
            LightboxConfig.CloseButton.text = ""
            let controller = LightboxController(images: images, startIndex: indexPath.row)
            
            controller.pageDelegate = self
            controller.dismissalDelegate = self
            controller.dynamicBackground = true
            isChangedImage = false
            
            present(controller, animated: true, completion: nil)
        } else {
            self.onPressedTakePhoto(self.btnTakePhotos)
        }
    }
}

extension JGGPostServiceDescribeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width - 30) / 4
        return CGSize(width: size, height: size)
    }
}

extension JGGPostServiceDescribeVC: LightboxControllerPageDelegate, LightboxControllerDismissalDelegate {
    func lightboxController(_ controller: LightboxController, didMoveToPage page: Int) {
        
    }
    
    func lightboxController(_ controller: LightboxController, didChange image: UIImage?, of page: Int) {
        isChangedImage = true
        selectedImages[page].1 = image
    }
    
    func lightboxControllerWillDismiss(_ controller: LightboxController) {
        if isChangedImage {
            self.collectionPhotos.reloadData()
        }
    }
}

