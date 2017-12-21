//
//  JGGProfileNC.swift
//  JacksGoGo
//
//  Created by Chris Lin on 12/22/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGProfileNC: JGGBaseNC {

    override func viewDidLoad() {
        super.viewDidLoad()

        if true {
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "JGGLoginVC") as! JGGLoginVC
            self.viewControllers = [loginVC]
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
