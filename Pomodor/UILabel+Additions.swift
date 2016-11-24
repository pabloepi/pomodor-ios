//
//  UILabel+Additions.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import Foundation

extension UILabel {
    
    func setText(text: String, spacing: Float) {
        
        let attributedString = NSMutableAttributedString(string: text)
            
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        
            self.attributedText = attributedString
    }
    
    func setLetterSpacing(spacing: Float) {
        
        self.setText(text: self.text!, spacing: spacing)
    }
    
}
