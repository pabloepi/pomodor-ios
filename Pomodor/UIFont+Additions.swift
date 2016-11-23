//
//  UIFont+Additions.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import Foundation

extension UIFont {
    
    class func primaryFontRegular(_ size: CGFloat) -> UIFont {
        
        return UIFont.init(name: Constants.Fonts.kPrimaryFontRegular, size: size)!
    }
    
    class func primaryFontSemibold(_ size: CGFloat) -> UIFont {
        
        return UIFont.init(name: Constants.Fonts.kPrimaryFontSemibold, size: size)!
    }
    
}
