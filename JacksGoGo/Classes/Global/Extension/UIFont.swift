//
//  UIFont.swift
//  JacksGoGo
//
//  Created by Hemin Wang on 25/10/2017.
//  Copyright © 2017 Hemin Wang. All rights reserved.
//

import UIKit

extension UIFont {
    static public var JGGTitle1: UIFont {
        get {
            let fontSize: CGFloat = 28
            return UIFont(name: "Muli-Bold", size: fontSize) ??
                UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    
    static public var JGGTitle2: UIFont {
        get {
            let fontSize: CGFloat = 22
            return UIFont(name: "Muli-Bold", size: fontSize) ??
                UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    
    static public var JGGTitle3: UIFont {
        get {
            let fontSize: CGFloat = 20
            return UIFont(name: "Muli-SemiBold", size: fontSize) ??
                UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    
    static public var JGGHeadline: UIFont {
        get {
            let fontSize: CGFloat = 17
            return UIFont(name: "Muli-Bold", size: fontSize) ??
                UIFont.boldSystemFont(ofSize: fontSize)
        }
    }

    static public var JGGBody: UIFont {
        get {
            let fontSize: CGFloat = 17
            return UIFont(name: "Muli-Regular", size: fontSize) ??
                UIFont.systemFont(ofSize: fontSize)
        }
    }

    static public var JGGButton: UIFont {
        get {
            let fontSize: CGFloat = 15
            return UIFont(name: "Muli-Bold", size: fontSize) ??
                UIFont.boldSystemFont(ofSize: fontSize)
        }
    }

    static public var JGGListTitle: UIFont {
        get {
            let fontSize: CGFloat = 15
            return UIFont(name: "Muli-Bold", size: fontSize) ??
                UIFont.boldSystemFont(ofSize: fontSize)
        }
    }

    static public var JGGListText: UIFont {
        get {
            let fontSize: CGFloat = 15
            return UIFont(name: "Muli-Regular", size: fontSize) ??
                UIFont.systemFont(ofSize: fontSize)
        }
    }

    static public var JGGCaption: UIFont {
        get {
            let fontSize: CGFloat = 12
            return UIFont(name: "Muli-Regular", size: fontSize) ??
                UIFont.systemFont(ofSize: fontSize)
        }
    }

}
