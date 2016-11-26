//
//  DeviceHelper.swift
//  Pomodor
//
//  Created by Pablo on 11/25/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import AVFoundation

struct DeviceHelper {
    
    static func vibrate() {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
}
