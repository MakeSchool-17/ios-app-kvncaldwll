//
//  ViewStreamViewController.swift
//  tcp-trial
//
//  Created by kevin caldwell on 1/10/16.
//  Copyright © 2016 iota. All rights reserved.
//

import UIKit

class ViewStreamViewController: UIViewController {
    
    var imageView: UIImageView?
    var imageStream = ImageStream()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView()
        let frame = CGRectMake(30, 150, 320, 240)
        imageView!.frame = frame
        self.view.addSubview(imageView!)
        self.imageStream.delegate = self
    }
    
    @IBAction func disconnectButton(sender: AnyObject) {
        
    }
    
    @IBAction func snapButton(sender: AnyObject) {
        
    }
    
}

extension ViewStreamViewController: ImageStreamDataDelegate {
    
    func imageDataRecieved(image: NSData) {
        let image: UIImage = UIImage(data: image)!
        imageView!.image = image
    }
}
