//
//  NotificationsController.swift
//  Pomodor
//
//  Created by Pablo on 11/26/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsController: NSObject {
    
    static let sharedInstance = NotificationsController()
    
    func scheduleLocalNotification(forTask task: String) {
        
        let localNotification = UILocalNotification()
        
        localNotification.fireDate                   = Date(timeIntervalSinceNow: 5) // Calculate Date using Task.remainingTime
        localNotification.alertTitle                 = "Task Completed"
        localNotification.alertBody                  = task
        localNotification.timeZone                   = TimeZone.current
        localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    class func registerUserNotification() {
        
        let notificationSettings = UIUserNotificationSettings (types: [.alert, .badge, .sound],
                                                               categories: nil)
        
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
    }
    
    class func zeroBadge() {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
}
