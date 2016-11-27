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
        
        let url = Bundle.main.url(forResource: "notification-sound",
                                  withExtension: "aiff")
        
        var soundID: SystemSoundID = 0
        
        AudioServicesCreateSystemSoundID(url as! CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID);
    }
    
}
