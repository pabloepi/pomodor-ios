//
//  UIButton+Additions.swift
//  Pomodor
//
//  Created by Pablo on 11/24/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    
    func enableButton() {
        
        self.alpha     = 1.0
        self.isEnabled = true
    }
    
    func disableButton() {
        
        self.alpha     = 0.3
        self.isEnabled = false
    }
}
