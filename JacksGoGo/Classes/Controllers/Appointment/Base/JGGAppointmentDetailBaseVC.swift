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
    @IBOutlet weak var imgviewCategoryIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblServiceTime: UILabel!

    var selectedAppointment: JGGJobModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCategoryAndTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func showCategoryAndTitle() {
        lblTitle.text = selectedAppointment?.title
        lblServiceTime.text = selectedAppointment?.jobTimeDescription()
        if let urlString = selectedAppointment?.category?.image,
            let url = URL(string: urlString) {
            imgviewCategoryIcon.af_setImage(withURL: url)
        }
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
