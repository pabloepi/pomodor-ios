//
//  Session+CoreDataClass.swift
//  Pomodor
//
//  Created by Pablo on 11/25/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Session)
public class Session: NSManagedObject {
    
    class func currentSession() -> Session {
        
        if let session = Session.mr_findFirst() {
            
            return session
        }
        
        let session = Session.mr_createEntity()
        
        DatabaseController.persist()
        
        return session!
    }
    
    class func sessionWithTask(task: Task) {
        
        let currentSession = Session.currentSession()
        
        currentSession.activeTask = task
        
        DatabaseController.persist()
    }
    
    class func deleteSession() {
        
        Session.mr_truncateAll()
        
        DatabaseController.persist()
    }

}
