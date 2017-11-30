//
//  JGGRequestQuotationVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/30/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGRequestQuotationVC: JGGServiceSubDetailBaseVC {

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
            let editJobStepRootVC = segue.destination as? JGGEditJobStepRootVC {
            editJobStepRootVC.isRequestQuotationMode = true
        }
    }
}
