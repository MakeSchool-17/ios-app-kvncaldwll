//
//  ImageStream.swift
//  tcp-trial
//
//  Created by kevin caldwell on 12/10/15.
//  Copyright © 2015 iota. All rights reserved.
//

import UIKit

public protocol ImageStreamDataDelegate {
    func imageDataRecieved(image:NSData)
}

class ImageStream: NSObject {
    
    var delegate: ImageStreamDataDelegate?
    
    let addr = "172.30.7.238"
    let port = 8000
    var inp: NSInputStream?
    var out: NSOutputStream?
    
    let bufferSize : UInt32 = 1000000
    let readSize : UInt32 = 4096
    
    func streamConnect() {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) {
        NSStream.getStreamsToHostWithName(self.addr, port: self.port, inputStream: &self.inp, outputStream: &self.out)
            self.inp!.delegate = self
            self.inp!.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            self.inp!.open()
            self.out!.open()
            
            NSRunLoop.currentRunLoop().run()
        }
    }
    
//    func readStream() -> NSData {
    
        

        
        //      inputStream.delegate = self
        //      let outputStream = out!

        
        //      outputStream.open()
        //      var buffer: [UInt8] = [103, 101, 116] //"get" in ASCII
        //      outputStream.write(&buffer, maxLength: buffer.count)
        
        //      let bufferSize = 1024000
        //      var inputBuffer = Array<UInt8>(count:bufferSize, repeatedValue: 0)
        //      let bytesRead = inputStream.read(&inputBuffer, maxLength: bufferSize)
        

        /*
        var bytesRead = UInt32(inputStream.read(&inputLength, maxLength: 4 ) )
        print(bytesRead)
        imageLength = UnsafePointer<UInt32>(inputLength).memory
        print(imageLength)
        print("image length")
        
        var readIndex : UInt32 = 0
        var readBytes = readSize
        
            while (readIndex < imageLength) {
        
                if ((readIndex + readSize ) > imageLength) {
                readBytes = imageLength - readIndex
                }
                
                bytesRead = UInt32(inputStream.read(&inputBuffer[Int(readIndex)], maxLength: Int(readBytes) ) )
                
                readIndex = readIndex + bytesRead
            }
        
        
        let pictureData = NSData(bytes: inputBuffer, length: Int(imageLength))

        return pictureData

    }
        */
        
//        return NSData() //FIXME: we will want to change this function to have no return type
//    }
 
    
}

extension ImageStream : NSStreamDelegate {
    
    internal func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        
        switch (eventCode){
            
        case NSStreamEvent.OpenCompleted:
            NSLog("Stream opened")
            break
        case NSStreamEvent.HasBytesAvailable:
            NSLog("HasBytesAvailable")
      
                if let imageStream = aStream as? NSInputStream {
                    var inputLength = Array<UInt8>(count:4, repeatedValue: 0)
                    var inputBuffer = Array<UInt8>(count:Int(self.bufferSize), repeatedValue: 0)
                    var imageLength : UInt32 = 0

                    var bytesRead : UInt32 = 0
                    
                    var readLengthIndex : UInt32 = 0
                    var readLengthBytes : UInt32 = 4
                    var totalLengthBytesRead : UInt32 = 0
                    
                    while (readLengthIndex < 4) {
                        
                        if (readLengthIndex > 0) {
                            readLengthBytes = 4 - readLengthIndex
                        }
                        
                        bytesRead = UInt32(imageStream.read(&inputLength[Int(readLengthIndex)], maxLength: Int(readLengthBytes) ) )
                        
                        readLengthIndex = readLengthIndex + bytesRead
                        totalLengthBytesRead = totalLengthBytesRead + bytesRead
                    }

                    print(totalLengthBytesRead)
                    imageLength = UnsafePointer<UInt32>(inputLength).memory
                    
                    print(imageLength)
                    print("image length")
                    

                    var readIndex : UInt32 = 0
                    var readBytes = self.readSize
                    
                    while (readIndex < imageLength) {
                        
                        if ((readIndex + self.readSize ) > imageLength) {
                            readBytes = imageLength - readIndex
                        }
                        
                        bytesRead = UInt32(imageStream.read(&inputBuffer[Int(readIndex)], maxLength: Int(readBytes) ) )
                        readIndex = readIndex + bytesRead
                    }
                    
                    let pictureData = NSData(bytes: inputBuffer, length: Int(imageLength))
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        if (self.delegate != nil)
                        {
                            self.delegate?.imageDataRecieved(pictureData)
                        }
                    })
                }
            break
        case NSStreamEvent.ErrorOccurred:
            NSLog("ErrorOccurred")
            print(aStream.streamError)
            break
        case NSStreamEvent.EndEncountered:
            NSLog("EndEncountered")
            break
        default:
            NSLog("Unknown.")
        }
        
        print("received callback!!!!")

    }
}