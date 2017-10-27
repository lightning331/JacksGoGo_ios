//
//  JGGAppFilterVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 27/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGAppFilterVC: JGGAppointmentsBaseVC {

    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var arrayFilterOptions: [[String: Any]] = [
        ["title" : "Jobs posted.",   "selected": true],
        ["title" : "Jobs accepted.", "selected": true],
        ["title" : "Invited jobs.",  "selected": true],
        ["title" : "Quick jobs.",    "selected": true],
        ["title" : "Events joined.", "selected": true],
        ["title" : "Events posted.", "selected": true],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "JGGSectionTitleView", bundle: nil),
                                forHeaderFooterViewReuseIdentifier: "JGGSectionTitleView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func onPressClose(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension JGGAppFilterVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "JGGSectionTitleView") as? JGGSectionTitleView
        view?.title = "Show Only"
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFilterOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGAppFilterOptionCell") as! JGGAppFilterOptionCell
        let filterOption = arrayFilterOptions[indexPath.row];
        cell.lblTitle.text = filterOption["title"] as? String;
        if let isSelected = filterOption["selected"] as? Bool {
            cell.isSelected = isSelected
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            arrayFilterOptions[indexPath.row]["selected"] = cell.isSelected
        }
    }
}
