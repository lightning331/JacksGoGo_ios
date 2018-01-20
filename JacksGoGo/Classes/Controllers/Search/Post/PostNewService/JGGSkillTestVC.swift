//
//  JGGSkillTestVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 12/5/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGSkillTestVC: JGGSearchBaseTableVC {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = true

        self.tableView.register(UINib(nibName: "JGGSkillTestQuestionCell", bundle: nil),
                                forCellReuseIdentifier: "JGGSkillTestQuestionCell")
    }

    @IBAction func onPressedSubmit(_ sender: Any) {
        JGGAlertViewController.show(title: LocalizedString("Submission Sent!"), message: LocalizedString("Thank you for verifying! Out team will contact you shourtly."), colorSchema: .green, okButtonTitle: LocalizedString("Back To Service Listing"), okAction: {
            self.navigationController?.popToRootViewController(animated: true)
        }, cancelButtonTitle: nil, cancelAction: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGSkillTestQuestionCell") as! JGGSkillTestQuestionCell
        if indexPath.row == 0 {
            cell.lblQuestion.text = "Question 1: Answer correctly"
        } else if indexPath.row == 1 {
            cell.lblQuestion.text = "Question 2: Select correct answer"
        } else if indexPath.row == 2 {
            cell.lblQuestion.text = "Question 3: And press submit button"
        }
        return cell
    }


}
