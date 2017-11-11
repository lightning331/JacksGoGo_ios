//
//  JGGAppointmentDetailBaseVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/10/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppointmentDetailBaseVC: JGGAppointmentsBaseVC {

    @IBOutlet weak var viewTitleBox: UIView!
    @IBOutlet weak var imgviewCategoryIcon: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblServiceTime: UILabel!

    var selectedAppointment: JGGAppointmentBaseModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCategoryAndTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showCategoryAndTitle() {
        lblTitle.text = "Gardening"
        lblServiceTime.text = "21 Jul, 2017 10:00 AM - 12:00 PM"
        
        if selectedAppointment?.type == .service {
            self.navigationItem.rightBarButtonItem = nil
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