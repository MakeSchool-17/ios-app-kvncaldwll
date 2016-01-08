//
//  ControllerStream.swift
//  tcp-trial
//
//  Created by kevin caldwell on 1/8/16.
//  Copyright © 2016 iota. All rights reserved.
//

import Foundation
import UIKit


class ControllerStream: NSObject {
    
    var out: NSOutputStream?
    var accelMotion = MotionControls()
    
    override init () {
        
        super.init()
        accelMotion.startMotionCapture()
        // implement stop motion updates
        
    }
    
}


extension ControllerStream : NSStreamDelegate {

    internal func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        
        switch (eventCode){
            
            case NSStreamEvent.OpenCompleted:
                NSLog("Controller stream opened")
                break
            case NSStreamEvent.HasBytesAvailable:
                NSLog("Controller bytes available")
                break
            case NSStreamEvent.ErrorOccurred:
                NSLog("Controller ErrorOccurred")
                print(aStream.streamError)
                break
            case NSStreamEvent.EndEncountered:
                NSLog("Controller EndEncountered")
                break
            default:
                NSLog("Controller Error Unknown.")
            
        }
    }
}