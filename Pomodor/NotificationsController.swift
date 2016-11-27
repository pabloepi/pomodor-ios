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
    
    func scheduleLocalNotification(forTask task: Task) {
        
        let localNotification = UILocalNotification()
        
        localNotification.fireDate                   = Date(timeIntervalSinceNow: task.remainingTime)
        localNotification.alertTitle                 = "Task Completed"
        localNotification.alertBody                  = "\(task.name!)"
        localNotification.timeZone                   = TimeZone.current
        localNotification.soundName                  = "notification-sound.aiff"
        localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }

    func removeScheduledLocalNotification() {
        
        UIApplication.shared.scheduledLocalNotifications?.removeAll()
    }
    
    func currentLocalNotification() -> UILocalNotification? {
        
        return UIApplication.shared.scheduledLocalNotifications?.first
    }
    
    class func hasScheduledNotification() -> Bool {
     
        return (UIApplication.shared.scheduledLocalNotifications?.count)! > 0
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
