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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectErrorLabel.hidden = true
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait]
    }
    
    @IBAction func startStream(sender: UIButton) {
        imageStream.streamConnect()
        
//        if(){
//            connectErrorLabel.text =  "hello"
//            connectErrorLabel.hidden = false
//        }
        
    }
    
    @IBOutlet weak var connectErrorLabel: UILabel!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let viewStreamViewController = segue.destinationViewController as? ViewStreamViewController else { return }
        viewStreamViewController.imageStream = self.imageStream
        
    }
    
}
