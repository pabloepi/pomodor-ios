//
//  DatabaseController.swift
//  Pomodor
//
//  Created by Pablo on 11/24/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import CoreData
import MagicalRecord

struct DatabaseController {
    
    static func persist() {
        
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
    }
    
    static func defaultContext() -> NSManagedObjectContext {
        
        return NSManagedObjectContext.mr_default()
    }
    
}
