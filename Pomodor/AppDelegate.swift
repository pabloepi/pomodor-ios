//
//  AppDelegate.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        StartupController.kickoff(launchOptions)
        
        NotificationsController.registerUserNotification()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        if !NotificationsController.hasScheduledNotification() {
            
            if let activeTask = Session.currentSession().activeTask {
                
                CountdownTimerController.sharedInstance.stopCountdown()
                
                activeTask.fireDate = Date(timeIntervalSinceNow: activeTask.remainingTime) as NSDate?
                
                NotificationsController.sharedInstance.scheduleLocalNotification(forTask: activeTask)
                
                DatabaseController.persist()
            }
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        NotificationsController.zeroBadge()
    }
    
}

