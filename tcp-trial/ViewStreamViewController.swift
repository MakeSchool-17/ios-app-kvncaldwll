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
    
    var newStreamView = UIImageView()
    var screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageStream = self.imageStream {
            imageStream.delegate = self
        }
        
        self.view.addSubview(self.newStreamView)
        self.newStreamView.frame = CGRectMake(0, 0, screenSize.width, screenSize.height)
    }
    
    @IBAction func disconnectButton(sender: AnyObject) {
        
    }
    
    @IBAction func snapButton(sender: AnyObject) {
        
    }
    
}


extension ViewStreamViewController: ImageStreamDataDelegate {
    
    func imageDataRecieved(image: NSData) {
        let image: UIImage = UIImage(data: image)!
        //self.streamView.image = image
        self.newStreamView.image = image
    }
    
}
