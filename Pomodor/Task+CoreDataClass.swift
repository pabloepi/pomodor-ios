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
    
    func markAsCompleted() {
        
        self.remainingTime = Double(0.00)
        self.completed     = true
        
        DatabaseController.persist()
    }
    
    fileprivate class func standardTimer() -> Double {
        
        return Double(10.00)
    }
    
}
