//
//  Task+CoreDataClass.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {

    class func task(_ name: String) -> Task? {
        
        let task = Task.mr_createEntity()
        
        task?.taskId        = NSUUID().uuidString
        task?.name          = name
        task?.remainingTime = standardTimer()
        task?.createdAt     = NSDate()
        task?.completed     = false
        
        DatabaseController.persist()
        
        return task
    }
    
    func reset() {
        
        self.remainingTime = Task.standardTimer()
    }
    
    fileprivate class func standardTimer() -> Double {
        
        return Double(20.00 * 60.00)
    }
    
}
