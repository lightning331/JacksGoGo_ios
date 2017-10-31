//
//  JGGBiddingProviderModel.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 31/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

class JGGBiddingProviderModel: JGGBaseModel {

    var user: JGGUserBaseModel!
    var price: Double = 0
    var status: BiddingStatus = .pending
    var isNew: Bool = false
    
}
