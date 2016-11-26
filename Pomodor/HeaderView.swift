//
//  HeaderView.swift
//  Pomodor
//
//  Created by Pablo on 11/24/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet fileprivate weak var container: UIView!
    
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
        
        self.completeLabel.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
    }
    
    func noTasks() {
        
        self.gradient.colors = [UIColor.pdrLightSkyTopColor().cgColor, UIColor.pdrLightSkyBottomColor().cgColor];
        
        changeTimeLabels(minutes: 00, seconds: 00)
        hideCompletedLabel()
    }
    
    func taskPaused(remainingTime: Double) {
        
        self.gradient.colors = [UIColor.pdrDarkBlueTopColor().cgColor, UIColor.pdrDarkBlueBottomColor().cgColor];

        changeTimeLabels(remainingTime)
        hideCompletedLabel()
    }
    
    func taskRunning(remainingTime: Double) {
        
        self.gradient.colors = [UIColor.pdrAliveRedTopColor().cgColor, UIColor.pdrAliveRedBottomColor().cgColor];
        
        changeTimeLabels(remainingTime)
        hideCompletedLabel()
    }
    
    func taskCompleted() {
        
        self.gradient.colors = [UIColor.pdrBrightGreenTopColor().cgColor, UIColor.pdrBrightGreenBottomColor().cgColor];
        
        showCompletedLabel()
        changeTimeLabels(00.00)
    }
    
    // MARK: - Private Methods
    
    fileprivate func showCompletedLabel() {
        
        UIView.animate(withDuration: 0.18,
                       animations: {
                        
                        self.completeLabel.transform = CGAffineTransform.identity
                        self.completeLabel.alpha     = 1.0
                        self.container.alpha         = 0.0
        })
    }
    
    fileprivate func hideCompletedLabel() {
        
        UIView.animate(withDuration: 0.18,
                       animations: {
                        
                        self.completeLabel.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                        self.completeLabel.alpha     = 0.0
                        self.container.alpha         = 1.0
        })
    }
    
    fileprivate func changeTimeLabels(_ remainingTime: Double) {
        
        let animation            = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type           = kCATransitionFade;
        animation.duration       = 0.12;
        
        self.minutesLabel.layer.add(animation, forKey: "kCATransitionFade")
        self.secondsLabel.layer.add(animation, forKey: "kCATransitionFade")
        
        let minutes = floor(remainingTime      / 60);
        let seconds = remainingTime - (minutes * 60);
        
        self.minutesLabel.text = NSString(format: "%02.0f", minutes) as String
        self.secondsLabel.text = NSString(format: "%02.0f", seconds) as String
    }
}
