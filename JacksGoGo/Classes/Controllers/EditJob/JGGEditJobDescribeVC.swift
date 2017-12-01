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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onPressedTakePhoto(_ sender: Any) {
        
        let photoPicker = JGGCustomPhotoPickerVC()
        photoPicker.delegate = self
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
        return 4
    }

}

extension JGGEditJobDescribeVC: TLPhotosPickerViewControllerDelegate {
    
}
