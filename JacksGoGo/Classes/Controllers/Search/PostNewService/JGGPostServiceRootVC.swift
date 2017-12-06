//
//  JGGPostServiceRootVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostServiceRootVC: JGGSearchBaseVC {

    @IBOutlet weak var imgviewCategory: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var viewContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "gotoEditJobStepRootVC",
            let nav = segue.destination as? JGGSearchNC, let
            editJobStepRootVC = nav.topViewController as? JGGEditJobStepRootVC {
        }
    }

}
