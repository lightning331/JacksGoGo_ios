//
//  JGGPostJobNC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 1/26/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

class JGGPostJobNC: UINavigationController {

    var editJob: JGGJobModel? {
        set {
            _editJob = newValue
            if let _ = newValue {
                isEditMode = true
            }
        }
        get {
            return _editJob
        }
    }
    private var _editJob: JGGJobModel?
    private var isEditMode: Bool = false
    private var isExecutedOne: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (!isExecutedOne && isEditMode) {
            isExecutedOne = true
            if let summaryVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGPostJobSummaryVC") as? JGGPostJobSummaryVC {
                summaryVC.editingJob = editJob
                self.pushViewController(summaryVC, animated: false)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
