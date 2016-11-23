//
//  HomeNavBar.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit

class HomeNavBar: UINavigationBar {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit() {
        
        self.isTranslucent   = true
        self.tintColor       = UIColor.white
        self.shadowImage     = UIImage()
        self.backgroundColor = UIColor.clear
        self.barTintColor    = UIColor.clear
        
        self.setBackgroundImage(UIImage(), for: .default)
        
        self.titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName           : UIFont.primaryFontSemibold(17.0)
        ]
    }
    
}
