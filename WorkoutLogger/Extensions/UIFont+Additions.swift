//
//  UIFont+Additions.swift
//  TiplrApp
//
//  Created by Gary on 1/26/16.
//  Copyright © 2016 Gary. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func swarm_bold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Bold", size: size)!
    }
    
    class func swarm_medium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Medium", size: size)!
    }
    
    class func swarm_light(_ size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Light", size: size)!
    }
    
    class func swarm_regular(withSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Regular", size: size)!
    }
    
}

