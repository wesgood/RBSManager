//
//  ViewController.swift
//  RBSManager
//
//  Created by wesgood on 01/06/2018.
//  Copyright (c) 2018 wesgood. All rights reserved.
//

import UIKit
import RBSManager

class ViewController: UIViewController {
    // user interface
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var upButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var downButton: UIButton!
    
    // turtle outputs
    @IBOutlet var turtleIconImage: UIImageView!
    @IBOutlet var turtleXLabel: UILabel!
    @IBOutlet var turtleYLabel: UILabel!
    @IBOutlet var turtleThetaLabel: UILabel!
    
    // RBSManager
    var turtleManager: RBSManager?
    var turtlePublisher: RBSPublisher?
    var turtleSubscriber: RBSSubscriber?
    
    // data handling
    let linearSpeed = 0.75
    let angularSpeed = Double.pi/8
    
    // user settings
    var socketHost: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDirectionButton(_ button: UIButton) {
        
    }

    @IBAction func onConnectButton() {
        
    }
}

