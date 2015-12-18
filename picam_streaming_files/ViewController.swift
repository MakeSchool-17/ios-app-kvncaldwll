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
        let frame = CGRectMake(0, 150, 640, 480)
        imageView!.frame = frame
        self.view.addSubview(imageView!)
    }
    
    @IBAction func connectButton(sender: UIButton){
        self.imageStream.delegate = self
        self.imageStream.streamConnect()
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
