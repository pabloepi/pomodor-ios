//
//  TaskCell.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import KVOController

class TaskCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var nameLabel:          UILabel!
    @IBOutlet fileprivate weak var remainingTimeLabel: UILabel!
    
    @IBOutlet fileprivate weak var completedImageView: UIImageView!
    
    var task: Task! {
        
        didSet {
            
            self.nameLabel.text           = self.task.name
            self.completedImageView.alpha = self.task.completed ? 1.0 : 0.0
            self.remainingTimeLabel.alpha = self.task.completed ? 0.0 : 1.0
            
            
            self.kvoController.observe(self.task,
                                       keyPath: "remainingTime",
                                       options: .old,
                                       block: { (observer: Any?, object: Any, change: [String : Any]) in
                                        
                                        if (Session.currentSession().activeTask?.isEqual(self.task))! {
                                            
                                            let minutes = floor(self.task.remainingTime      / 60);
                                            let seconds = self.task.remainingTime - (minutes * 60);
                                            
                                            self.remainingTimeLabel.text = NSString(format: "%02.0f:%02.0f", minutes, seconds) as String
                                        }
            })
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods
    
    class func identifier() -> String {
        
        return String(describing: TaskCell.self)
    }
    
    func currentTask(isCurrent: Bool) {
        
        self.backgroundColor              = isCurrent ? UIColor.white                    : UIColor.clear
        self.nameLabel.textColor          = isCurrent ? UIColor.pdrTextColor()           : UIColor.pdrText50Color()
        self.remainingTimeLabel.textColor = isCurrent ? UIColor.pdrDarkBlueBottomColor() : UIColor.pdrText40Color()
    }
    
    func activeTaskNotCurrent() {
        
        self.backgroundColor     = UIColor.clear
        self.nameLabel.textColor = UIColor.pdrText50Color()
    }
    
    func activeTask() {
        
        self.backgroundColor              = UIColor.white
        self.nameLabel.textColor          = UIColor.pdrTextColor()
        self.remainingTimeLabel.textColor = UIColor.pdrAliveRedTopColor()
    }
    
}
