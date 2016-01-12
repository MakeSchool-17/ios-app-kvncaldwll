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
    }
    
}


extension ControllerStream : NSStreamDelegate {

    internal func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        
        switch (eventCode){
            
            case NSStreamEvent.OpenCompleted:
                NSLog("Controller Stream Opened")
                break
            
            case NSStreamEvent.HasBytesAvailable:
                NSLog("Controller Bytes Available")
                
                if let imageStream = aStream as? NSOutputStream {
                
                    let data: NSData = self.accelMotion.retrieveGyroscopeValues()
                    out!.write(<#T##buffer: UnsafePointer<UInt8>##UnsafePointer<UInt8>#>, maxLength: <#T##Int#>)
                }
                
                break
            
            case NSStreamEvent.ErrorOccurred:
                NSLog("Controller Error Occurred")
                print(aStream.streamError)
                break
            
            case NSStreamEvent.EndEncountered:
                NSLog("Controller End Encountered")
                break
            
            default:
                NSLog("Controller Error Unknown.")
            
        }
        
    }
    
}