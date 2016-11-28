//
//  Task+CoreDataProperties.swift
//  Pomodor
//
//  Created by Pablo on 11/27/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task");
    }

    @NSManaged public var completed: Bool
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var remainingTime: Double
    @NSManaged public var taskId: String?
    @NSManaged public var fireDate: NSDate?

}
