//
//  ControlsView.swift
//  Pomodor
//
//  Created by Pablo on 11/24/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit

class ControlsView: UIView {

    @IBOutlet fileprivate weak var resetButton: UIButton!
    @IBOutlet fileprivate weak var stopButton:  UIButton!
    @IBOutlet fileprivate weak var startButton: UIButton!
    
    var didTouchStart: (() -> Void)?
    var didTouchStop:  (() -> Void)?
    var didTouchReset: (() -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        resetButton.addTarget(self, action: #selector(ControlsView.resetTouchUpInside), for: .touchUpInside)
        stopButton.addTarget(self,  action: #selector(ControlsView.stopTouchUpInside),  for: .touchUpInside)
        startButton.addTarget(self, action: #selector(ControlsView.startTouchUpInside), for: .touchUpInside)
    }
    
    @objc fileprivate func resetTouchUpInside() {
        
        didTouchReset?()
    }
    
    @objc fileprivate func stopTouchUpInside()  {
        
        didTouchStop?()
    }
    
    @objc fileprivate func startTouchUpInside() {
        
        didTouchStart?()
    }
    
    func noTasks() {
        
        self.stopButton.disableButton()
        self.startButton.disableButton()
        self.resetButton.disableButton()
    }
    
    func taskPaused() {
        
        self.stopButton.disableButton()
        self.startButton.enableButton()
        self.resetButton.enableButton()
    }
    
    func taskRunning() {
        
        self.stopButton.enableButton()
        self.startButton.disableButton()
        self.resetButton.enableButton()
    }
    
    func taskCompleted() {
        
        self.stopButton.disableButton()
        self.startButton.disableButton()
        self.resetButton.disableButton()
    }

}
