//
//  ViewController.swift
//  RBSManager
//
//  Created by wesgood on 01/06/2018.
//  Copyright (c) 2018 wesgood. All rights reserved.
//

import UIKit
import RBSManager

class ViewController: UIViewController, RBSManagerDelegate {
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
    let linearSpeed: Float = 0.75
    let angularSpeed: Float = Float.pi/8
    
    // user settings
    var socketHost: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        turtleManager = RBSManager.sharedManager()
        turtleManager?.delegate = self
        updateButtonStates(false)
        
        // create the publisher and subscriber
        turtlePublisher = turtleManager?.addPublisher(topic: "turtle1/cmd_vel", messageType: "geometry_msgs/Twist", messageClass: TwistMessage.self)
        turtleSubscriber = turtleManager?.addSubscriber(topic: "turtle1/pose", messageClass: PoseMessage.self, response: { (message) -> (Void) in
            // update the view with message data
            updateWithMessage(message)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func managerDidConnect(_ manager: RBSManager) {
        updateButtonStates(true)
    }
    
    func managerDidTimeout(_ manager: RBSManager) {
        updateButtonStates(false)
        print("connection did timeout")
    }
    
    func manager(_ manager: RBSManager, didDisconnect error: Error?) {
        updateButtonStates(false)
        print(error?.localizedDescription ?? "connection did disconnect")
    }
    
    @IBAction func onDirectionButton(_ button: UIButton) {
        // build the message based on the button tapped
        let message = TwistMessage()
        if button == upButton || button == downButton {
            if button == upButton {
                message.linear?.x = linearSpeed
            } else {
                message.linear?.x = -linearSpeed
            }
        } else {
            if button == leftButton {
                message.angular?.z = -angularSpeed
            } else {
                message.angular?.z = angularSpeed
            }
        }
        
        // send the message with the publisher
        turtlePublisher?.publish(message)        
    }

    @IBAction func onConnectButton() {
        if turtleManager?.connected == true {
            turtleManager?.disconnect()
        } else {
            if socketHost != nil {
                // the connection requires a valid URL and will throw an error if it is invalid
                do {
                    try turtleManager?.connect(address: socketHost!)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                // print log error
                print("Missing socket host value")
            }
        }
    }
    
    func updateButtonStates(_ connected: Bool) {
        leftButton.isEnabled = connected
        rightButton.isEnabled = connected
        downButton.isEnabled = connected
        upButton.isEnabled = connected
        
        if connected {
            let redColor = UIColor(red: 0.329, green: 0.729, blue: 0.273, alpha: 1.0)
            connectButton.backgroundColor = redColor
            connectButton.setTitle("DISCONNECT", for: .normal)
        } else {
            let greenColor = UIColor(red: 0.729, green: 0.131, blue: 0.144, alpha: 1.0)
            connectButton.backgroundColor = greenColor
            connectButton.setTitle("CONNECT", for: .normal)
        }
    }
    
    func updateWithMessage(_ message: PoseMessage) {
        turtleXLabel.text = String(describing: message.x ?? 0)
        turtleYLabel.text = String(describing: message.y ?? 0)
        turtleThetaLabel.text = String(describing: message.theta ?? 0)
    }
}

