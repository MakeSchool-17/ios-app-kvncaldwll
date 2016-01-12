//
//  ViewStreamViewController.swift
//  tcp-trial
//
//  Created by kevin caldwell on 1/10/16.
//  Copyright © 2016 iota. All rights reserved.
//

import UIKit


class ViewStreamViewController: UIViewController {
    
    var imageStream: ImageStream?
    
    
    @IBOutlet weak var viewStream: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageStream = self.imageStream {
            imageStream.delegate = self
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight]
    }
    
    @IBAction func disconnectButton(sender: AnyObject) {
        
    }
    
    @IBAction func snapButton(sender: AnyObject) {
        
    }
    
}


extension ViewStreamViewController: ImageStreamDataDelegate {
    
    func imageDataRecieved(image: NSData) {
        let image: UIImage = UIImage(data: image)!
        self.viewStream.image = image
    }
    
}
