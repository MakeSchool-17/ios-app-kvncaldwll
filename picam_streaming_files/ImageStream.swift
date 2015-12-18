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
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        inp!.delegate = self
        inp!.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        inp!.open()
        out!.open()
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
                var inputBuffer = Array<UInt8>(count:Int(bufferSize), repeatedValue: 0)
                var imageLength : UInt32 = 0

                var bytesRead : UInt32 = 0
                
                var readLengthIndex : UInt32 = 0
                var readLengthBytes : UInt32 = 4
                var totalLengthBytesRead : UInt32 = 0
                
//              var bytesRead = UInt32(imageStream.read(&inputLength, maxLength: 4 ) )
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
                var readBytes = readSize
                
                while (readIndex < imageLength) {
                    
                    if ((readIndex + readSize ) > imageLength) {
                        readBytes = imageLength - readIndex
                    }
                    
                    bytesRead = UInt32(imageStream.read(&inputBuffer[Int(readIndex)], maxLength: Int(readBytes) ) )
                    
                    readIndex = readIndex + bytesRead
                }
                let pictureData = NSData(bytes: inputBuffer, length: Int(imageLength))
                
                if (self.delegate != nil)
                {
                    self.delegate?.imageDataRecieved(pictureData)
                }
            }
            break
        case NSStreamEvent.ErrorOccurred:
            NSLog("ErrorOccurred")
            break
        case NSStreamEvent.EndEncountered:
            NSLog("EndEncountered")
            break
        default:
            NSLog("Unknown.")
        }
        
        print("got the callback whoah!!!!")
    }
}