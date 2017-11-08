//
//  JGGEditJobTimeVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/8/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGEditJobTimeVC: JGGEditJobBaseTableVC {

    @IBOutlet weak var viewCalenarContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "JGGTimeSlotCell", bundle: nil),
                                forCellReuseIdentifier: "JGGTimeSlotCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.frame.width, height: 50)))
        label.backgroundColor = UIColor.JGGWhite
        label.font = UIFont.JGGListTitle
        label.textAlignment = .center
        label.text = LocalizedString("Time Slots")
        return label
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JGGTimeSlotCell") as! JGGTimeSlotCell
        
        return cell
    }
}
