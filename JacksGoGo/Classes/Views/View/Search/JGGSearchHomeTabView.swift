//
//  JGGServiceHomeTabView.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/12/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

public enum SearchTabButton {
    case services
    case jobs
    case goclub
    case search
}


class JGGSearchHomeTabView: UIView {

    @IBOutlet weak var btnServices: UIButton!
    @IBOutlet weak var viewServiceDot: UIView!
    @IBOutlet weak var btnJobs: UIButton!
    @IBOutlet weak var viewJobsDot: UIView!
    @IBOutlet weak var btnGoClub: UIButton!
    @IBOutlet weak var viewGoClubDot: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    
    var delegate: JGGSearchHomeTabViewDelegate?
    
    fileprivate var selectedTabButton: UIButton!
    
    // MARK: -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedTabButton = self.btnServices
        
        btnServices.setTitleColor(UIColor.JGGGreen, for: .normal)
        viewServiceDot.isHidden = false
        
        btnJobs.setTitleColor(UIColor.JGGBlack, for: .normal)
        viewJobsDot.isHidden = true
        
        btnGoClub.setTitleColor(UIColor.JGGBlack, for: .normal)
        viewGoClubDot.isHidden = true

    }
    
    @IBAction func onPressButton(_ sender: UIButton) {
        
        if selectedTabButton == sender {
            return
        }
        
        if sender == btnSearch {
            delegate?.searchHomeTabView(self, selectedButton: .search)
        } else {

            viewServiceDot.isHidden = true
            viewJobsDot.isHidden = true
            viewGoClubDot.isHidden = true
            
            btnServices.setTitleColor(UIColor.JGGBlack, for: .normal)
            btnJobs.setTitleColor(UIColor.JGGBlack, for: .normal)
            btnGoClub.setTitleColor(UIColor.JGGBlack, for: .normal)
            
            if sender == btnServices {
                delegate?.searchHomeTabView(self, selectedButton: .services)
                btnServices.setTitleColor(UIColor.JGGGreen, for: .normal)
                viewServiceDot.isHidden = false
            }
            else if sender == btnJobs {
                delegate?.searchHomeTabView(self, selectedButton: .jobs)
                btnJobs.setTitleColor(UIColor.JGGGreen, for: .normal)
                viewJobsDot.isHidden = false
            }
            else if sender == btnGoClub {
                delegate?.searchHomeTabView(self, selectedButton: .goclub)
                btnGoClub.setTitleColor(UIColor.JGGGreen, for: .normal)
                viewGoClubDot.isHidden = false
            }
            selectedTabButton = sender
        }
    }
}

protocol JGGSearchHomeTabViewDelegate {
    func searchHomeTabView(_ view: JGGSearchHomeTabView, selectedButton: SearchTabButton) -> Void
}
