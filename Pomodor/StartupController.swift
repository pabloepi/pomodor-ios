//
//  StartupController.swift
//  Pomodor
//
//  Created by Pablo on 11/23/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import MagicalRecord

class StartupController: NSObject {
    
    class func kickoff(_ options: [AnyHashable: Any]?) {
        
        //setupFabric()
        setupMagicalRecord()
    }
    
    fileprivate class func setupFabric() {
        
        Fabric.with([Crashlytics.self])
    }
    
    fileprivate class func setupMagicalRecord() {
        
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "Pomodor")
    }
    
}
