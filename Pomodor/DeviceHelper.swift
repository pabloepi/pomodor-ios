//
//  DeviceHelper.swift
//  Pomodor
//
//  Created by Pablo on 11/25/16.
//  Copyright © 2016 Pomodor. All rights reserved.
//

import AVFoundation
import AudioToolbox

struct DeviceHelper {
    
    static func vibrate() {
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    static func playSuccess() {
        
        let path = Bundle.main.path(forResource: "notification-sound",
                                    ofType: "aiff")
        
        var soundID: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(path as! CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID);
        AudioServicesDisposeSystemSoundID(soundID);
    }
    
}
