//
//  CountdownTimerController.swift
//  Pomodor
//
//  Created by Pablo on 11/25/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import Foundation

class CountdownTimerController: NSObject {
    
    static let sharedInstance = CountdownTimerController()
    
    fileprivate var timer: Timer!
    
    fileprivate var count: Double = 0.0
    
    var didUpdateCountdown:   ((_ remainingTime: Double) -> Void)?
    var didCompleteCountdown: (() -> Void)?
    
    func startCountdown(_ remainingTime: Double) {
        
        count = remainingTime
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(CountdownTimerController.updateCountdown),
                                         userInfo: .none,
                                         repeats: true)
    }
    
    func stopCountdown() {
        
        invalidateTimer()
    }
    
    // MARK: - Private Methods
    
    @objc fileprivate func updateCountdown() {
     
        if count > 0 {
            
            count -= 1
            
        } else {
            
            invalidateTimer()
        }
    }
    
    fileprivate func invalidateTimer() {
        
        self.timer.invalidate()
        self.timer = .none
    }
}