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
    var writtenToOutput = false
    
    override init () {
        super.init()
        accelMotion.startMotionCapture()
    }
    
}

extension ControllerStream : NSStreamDelegate {

    internal func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        
        switch (eventCode){
            
            case NSStreamEvent.OpenCompleted:
                print("Controller Stream Opened")
                writtenToOutput = false
                break
            
            case NSStreamEvent.HasSpaceAvailable:
                print("Controller Space Available")
                
//            if (!writtenToOutput) {
                    let string: String = "[ hello world ]"
                    let data = string.dataUsingEncoding(NSUTF8StringEncoding)
                    out!.write(UnsafePointer<UInt8>(data!.bytes), maxLength: data!.length)
                    writtenToOutput = true
//                }
        
                break
            
            case NSStreamEvent.ErrorOccurred:
                print("Controller Error Occurred")
                print(aStream.streamError)
                break
            
            case NSStreamEvent.EndEncountered:
                print("Controller End Encountered")
                break
            
            default:
                print("Controller Error Unknown.")
            
        }
        
    }
    
}