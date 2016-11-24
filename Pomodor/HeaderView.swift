//
//  HeaderView.swift
//  Pomodor
//
//  Created by Pablo on 11/24/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    @IBOutlet fileprivate weak var minutesLabel: UILabel!
    @IBOutlet fileprivate weak var secondsLabel: UILabel!
    
    @IBOutlet fileprivate weak var completeLabel: UILabel!
    
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
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        self.minutesLabel.setLetterSpacing(spacing: -2.00)
        self.secondsLabel.setLetterSpacing(spacing: -2.00)
    }
    
    func noTasks() {
        
        self.gradient.colors = [UIColor.pdrLightSkyTopColor().cgColor, UIColor.pdrLightSkyBottomColor().cgColor];
        
        changeTimeLabels(minutes: 00, seconds: 00)
    }
    
    func taskPaused(remainingTime: Double) {
        
        self.gradient.colors = [UIColor.pdrDarkBlueTopColor().cgColor, UIColor.pdrDarkBlueBottomColor().cgColor];
        
        let minutes = floor(remainingTime / 60);
        let seconds = remainingTime - (minutes * 60);
        
        changeTimeLabels(minutes: minutes, seconds: seconds)
    }
    
    func taskRunning(remainingTime: Double) {
        
        self.gradient.colors = [UIColor.pdrAliveRedTopColor().cgColor, UIColor.pdrAliveRedBottomColor().cgColor];
        
        let minutes = floor(remainingTime / 60);
        let seconds = remainingTime - (minutes * 60);
        
        changeTimeLabels(minutes: minutes, seconds: seconds)
    }
    
    func taskCompleted() {
        
        self.gradient.colors = [UIColor.pdrBrightGreenTopColor().cgColor, UIColor.pdrBrightGreenBottomColor().cgColor];
        
        changeTimeLabels(minutes: 00, seconds: 00)
    }
    
    fileprivate func changeTimeLabels(minutes: Double, seconds: Double) {
        
        let animation            = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type           = kCATransitionFade;
        animation.duration       = 0.18;
        
        self.minutesLabel.layer.add(animation, forKey: "kCATransitionFade")
        self.secondsLabel.layer.add(animation, forKey: "kCATransitionFade")
        
        self.minutesLabel.text = NSString(format: "%02.0f", minutes) as String
        self.secondsLabel.text = NSString(format: "%02.0f", seconds) as String
    }
}