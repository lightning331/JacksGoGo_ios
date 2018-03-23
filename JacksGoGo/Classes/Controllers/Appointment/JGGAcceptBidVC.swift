//
//  JGGAcceptBidVC.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 3/23/18.
//  Copyright © 2018 Hemin Wang. All rights reserved.
//

import UIKit
import Cosmos
import MBProgressHUD

class JGGAcceptBidVC: JGGAppointmentDetailBaseVC {

    @IBOutlet weak var imgviewUserAvatar: JGGCircleImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var ratebarUserRate: CosmosView!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnPaymentCreditCard: JGGButton!
    @IBOutlet weak var btnPaymentJacksCredit: JGGButton!
    
    var proposal: JGGProposalModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showUserInformation()
        showPaymentInformation()
    }
    
    fileprivate func showUserInformation() {
        
        let userProfile = proposal.userProfile
        
        let placeholderAvatar = UIImage(named: "icon_Profile")
        if let urlString = userProfile?.user.photoURL,
            let url = URL(string: urlString)
        {
            imgviewUserAvatar.af_setImage(withURL: url, placeholderImage: placeholderAvatar)
        } else {
            imgviewUserAvatar.image = placeholderAvatar
        }
        lblUsername.text = userProfile?.user.fullname
        ratebarUserRate.rating = userProfile?.user.rate ?? 0
        
        lblPrice.text = proposal.budgetDescription()
    }
    
    fileprivate func showPaymentInformation() {
        var desc: String = LocalizedString("Congratulations on finding a good match!\n\nNext, let's set up a payment method. Setting up a payment method allows for faster checkout.")
        var creditCardString: String = LocalizedString("Set Up Payment Method")
        let jacksCreditString: String = LocalizedString("Pay by Jacks Credit - balance") + String(format: " $ %.2f", proposal.budget ?? 0)
        if true { // Not setup payment
            desc = LocalizedString("Congratulations on finding a good match!\n\nNext, let's get up a paymnt method. The payment will only be released when the job is completed.")
            creditCardString = "Pay by credit card ending in 2999"
        }
        lblDescription.text = desc
        btnPaymentCreditCard.setTitle(creditCardString, for: .normal)
        btnPaymentJacksCredit.setTitle(jacksCreditString, for: .normal)
        if false { // No jacks credit
            btnPaymentJacksCredit.disable()
        }
    }
    
    @IBAction fileprivate func onPressedCreditCard(_ sender: UIButton) {
        acceptBid()
    }
    
    @IBAction fileprivate func onPressedJacksCredit(_ sender: UIButton) {
        acceptBid()
    }
    
    fileprivate func acceptBid() {
        let hud = MBProgressHUD.showAdded(to: self.navigationController!.view, animated: true)
        APIManager.approveProposal(self.proposal) { (contractId, errorMessage) in
            hud.hide(animated: true)
            if let contractId = contractId {
                print(contractId)
            } else {
                print(errorMessage ?? "Error")
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
