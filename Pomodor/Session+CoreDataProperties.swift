//
//  Session+CoreDataProperties.swift
//  Pomodor
//
//  Created by Pablo on 11/25/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import Foundation
import CoreData


extension Session {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Session> {
        return NSFetchRequest<Session>(entityName: "Session");
    }

    @NSManaged public var activeTask: Task?

}
