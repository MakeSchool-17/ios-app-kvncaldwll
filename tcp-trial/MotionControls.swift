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
        
        if motionKit.manager.accelerometerAvailable {
            
            motionKit.getAccelerometerValues(1, values: nil)
            
        }
        
    }
    
}


extension MotionControls: MotionKitDelegate {
    
    func retrieveAccelerometerValues (x: Double, y:Double, z:Double, absoluteValue: Double) {
        
            print("x: \(x)")
            print("y: \(y)")
            print("z: \(z)")
        
    }
    
}