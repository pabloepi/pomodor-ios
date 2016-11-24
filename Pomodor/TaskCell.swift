//
//  TaskCell.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var nameLabel:          UILabel!
    @IBOutlet fileprivate weak var remainingTimeLabel: UILabel!
    
    @IBOutlet fileprivate weak var completedImageView: UIImageView!
    
    var task: Task! {
        
        didSet {
            
            self.nameLabel.text           = self.task.name
            self.completedImageView.alpha = self.task.completed ? 1.0 : 0.0
            self.remainingTimeLabel.alpha = self.task.completed ? 0.0 : 1.0
            
            /*
             self.kvoController.observe(self.message,
             keyPath: "opened",
             options: .old,
             block: { (observer: Any?, object: Any, change: [String : Any]) in
             
             self.cardView.opened = self.message.opened
             })
             */
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods
    
    class func identifier() -> String {
        
        return String(describing: TaskCell.self)
    }
    
}
