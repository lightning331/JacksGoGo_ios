//
//  JGGPostServiceTimeSlotsNC.swift
//  JacksGoGo
//
//  Created by Chris Lin on 1/20/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit

public enum JGGTimeSlotPeopleType {
    case onePerson
    case multiplePeople
    case noSlots
}

class JGGPostServiceTimeSlotsNC: UINavigationController {

    var selectedPeopleType: JGGTimeSlotPeopleType = .noSlots
    lazy var onePersonTimeSlots: [JGGTimeSlotModel] = []
    lazy var multiplePeopleTimeSlots: [ JGGTimeSlotModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
