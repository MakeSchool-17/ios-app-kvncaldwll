//
//  MotionControls.swift
//  tcp-trial
//
//  Created by kevin caldwell on 1/8/16.
//  Copyright © 2016 iota. All rights reserved.
//

import Foundation

class MotionControls: NSObject {

    var motionKit = MotionKit()
    
    override init() {
        super.init()
        motionKit.delegate = self
    }
    
    func startMotionCapture () {
        if motionKit.manager.gyroAvailable {
            motionKit.getGyroValues(1, values: nil)
        }
        
        if motionKit.manager.deviceMotionAvailable {
            motionKit.getRotationRateFromDeviceMotion(1, values: nil)
        }
    }
    
}


extension MotionControls: MotionKitDelegate {
    
    func retrieveGyroscopeValues(x: Double, y: Double, z: Double, absoluteValue: Double) {
        print("gyro x: \(x)")
        print("gyro y: \(y)")
        print("gyro z: \(z)")
        print("gyro absolute value: \(absoluteValue)")
    }
    
    func getRotationRateFromDeviceMotion(x: Double, y: Double, z: Double) {
        print("rotation rate x: \(x)")
        print("rotation rate y: \(y)")
        print("rotation rate z: \(z)")
        print("_____________________")

    }
    
}