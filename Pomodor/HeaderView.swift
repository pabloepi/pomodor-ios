//
//  HeaderView.swift
//  Pomodor
//
//  Created by Pablo on 11/24/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    fileprivate var gradient: CAGradientLayer!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        setup()
    }
    
    fileprivate func setup() {
        
        self.gradient              = CAGradientLayer()
        self.gradient.frame        = self.bounds;
        self.gradient.startPoint   = CGPoint(x: 1.0, y: 0.0)
        self.gradient.endPoint     = CGPoint(x: 0.0, y: 1.0)
        self.gradient.colors       = [UIColor.pdrLightSkyTopColor().cgColor, UIColor.pdrLightSkyBottomColor().cgColor];
        
        self.layer.insertSublayer(self.gradient, at: 0)
    }
    
    func noTasks() {
        
        self.gradient.colors = [UIColor.pdrLightSkyTopColor().cgColor, UIColor.pdrLightSkyBottomColor().cgColor];
    }
    
    func taskPaused() {
        
        self.gradient.colors = [UIColor.pdrDarkBlueTopColor().cgColor, UIColor.pdrDarkBlueBottomColor().cgColor];
    }
    
    func taskRunning() {
        
        self.gradient.colors = [UIColor.pdrAliveRedTopColor().cgColor, UIColor.pdrAliveRedBottomColor().cgColor];
    }
    
    func taskCompleted() {
        
        self.gradient.colors = [UIColor.pdrBrightGreenTopColor().cgColor, UIColor.pdrBrightGreenBottomColor().cgColor];
    }
}
