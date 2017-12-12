//
//  String.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 11/7/17.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font : font],
                                            context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        
        return ceil(boundingBox.width)
    }
    
    static func attributedWith(bold: String?, regular: String?) -> NSAttributedString? {
        let boldString = bold == nil ? "" : bold!
        let text = boldString + (regular == nil ? "" : regular!)
        guard text.count > 0 else {
            return nil
        }
        let attributes = [ NSAttributedStringKey.font : UIFont.JGGListTitle ]
        let regularAttributes = [ NSAttributedStringKey.font : UIFont.JGGListText ]
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        if boldString.count > 0 {
            let regularRange = NSRange(location: boldString.count, length: text.count - boldString.count)
            attributedString.addAttributes(regularAttributes, range: regularRange)
        }
        return attributedString
    }
    
    func toBold(strings: [String], regularFont: UIFont = UIFont.JGGListText, boldFont: UIFont = UIFont.JGGListTitle) -> NSAttributedString? {
        let boldAttributes = [ NSAttributedStringKey.font : boldFont ]
        let regularAttributes = [ NSAttributedStringKey.font : regularFont ]
        let attributedString = NSMutableAttributedString(string: self, attributes: regularAttributes)
        for boldString in strings {
            let boldRange = (self as NSString).range(of: boldString)
            attributedString.addAttributes(boldAttributes, range: boldRange)
        }
        return attributedString
    }
}
