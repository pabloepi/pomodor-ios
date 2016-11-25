//
//  UIColor+Additions.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {

    class func pdrCellBackgroundColor() -> UIColor {
        
        return UIColor(red:0.97, green:0.97, blue:0.97, alpha:1)
    }
    
    // MARK: - Header No Tasks Colors
    
    class func pdrLightSkyTopColor() -> UIColor {
        
        return UIColor(red:0.38, green:0.47, blue:0.66, alpha:1)
    }
    
    class func pdrLightSkyBottomColor() -> UIColor {
        
        return UIColor(red:0.8, green:0.82, blue:0.87, alpha:1)
    }
    
    // MARK: - Header Paused Task Colors
    
    class func pdrDarkBlueTopColor() -> UIColor {
        
        return UIColor(red:0.15, green:0.39, blue:0.4, alpha:1)
    }
    
    class func pdrDarkBlueBottomColor() -> UIColor {
        
        return UIColor(red:0.31, green:0.24, blue:0.49, alpha:1)
    }
    
    // MARK: - Header Running Task Colors
    
    class func pdrAliveRedTopColor() -> UIColor {
        
        return UIColor(red:1, green:0.14, blue:0.43, alpha:1)
    }
    
    class func pdrAliveRedBottomColor() -> UIColor {
        
        return UIColor(red:1, green:0.25, blue:0.14, alpha:1)
    }
    
    // MARK: - Header Completed Colors
    
    class func pdrBrightGreenTopColor() -> UIColor {
        
        return UIColor(red:0.28, green:0.87, blue:0.47, alpha:1)
    }
    
    class func pdrBrightGreenBottomColor() -> UIColor {
        
        return UIColor(red:0, green:0.83, blue:0.29, alpha:1)
    }
}
