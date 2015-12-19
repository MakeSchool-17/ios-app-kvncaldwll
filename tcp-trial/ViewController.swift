//
//  ViewController.swift
//  tcp-trial
//
//  Created by kevin caldwell on 12/3/15.
//  Copyright © 2015 iota. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var imageView: UIImageView?
    var imageStream = ImageStream()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = UIImageView()
        let frame = CGRectMake(30, 150, 320, 240)
        imageView!.frame = frame
        self.view.addSubview(imageView!)
        self.imageStream.delegate = self
    }
    
    
    @IBAction func startStream(sender: UIButton) {
        self.imageStream.streamConnect()
    }
    
    var pan: Int = 90
    var tilt: Int = 90
    var snap: Bool = false
    
    @IBAction func panLeft(sender: UIButton) {
        if pan > 40 {
            pan = pan - 3
            NSLog( "pan " + String(pan) )
        }
    }
    
    @IBAction func panRight(sender: UIButton) {
        if pan < 120 {
            pan = pan + 3
            NSLog( "pan " + String(pan) )
        }
    }
    
    @IBAction func tiltUp(sender: UIButton) {
        if tilt < 120 {
            tilt = tilt + 3
            NSLog( "tilt " + String(tilt) )
        }
    }
    
    @IBAction func tiltDown(sender: UIButton) {
        if tilt > 40 {
            tilt = tilt - 3
            NSLog( "tilt " + String(tilt) )
        }
    }
    
    @IBAction func centerCam(sender: UIButton) {
        tilt = 90
        pan = 90
        NSLog( "pan " + String(pan) )
        NSLog( "tilt " + String(tilt) )
    }
    
    @IBAction func snap(sender: UIButton) {
        snap = true
        NSLog( String(snap) )
        if snap {
            snap = false
            NSLog( String(snap) )
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: ImageStreamDataDelegate {
    
    func imageDataRecieved(image: NSData) {
        let image: UIImage = UIImage(data: image)!
        imageView!.image = image
    }
}