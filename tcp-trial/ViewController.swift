//
//  ViewController.swift
//  tcp-trial
//
//  Created by kevin caldwell on 12/3/15.
//  Copyright © 2015 iota. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var imageStream = ImageStream()
    var viewStream = ViewStreamViewController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    
    @IBAction func startStream(sender: UIButton) {
        
        self.imageStream.streamConnect()
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}
