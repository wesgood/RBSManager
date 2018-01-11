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
    var hostButton: UIBarButtonItem?
    var resetButton: UIBarButtonItem?
    var flexibleToolbarSpace: UIBarButtonItem?
    
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
        self.edgesForExtendedLayout = []
        turtleManager = RBSManager.sharedManager()
        turtleManager?.delegate = self
        updateButtonStates(false)
        
        // load settings to retrieve the stored host value
        loadSettings()
        
        // add toolbar buttons
        resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(onResetButton))
        hostButton = UIBarButtonItem(title: "Host", style: .plain, target: self, action: #selector(onHostButton))
        flexibleToolbarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        updateToolbarItems()
        
        
        // create the publisher and subscriber
        turtlePublisher = turtleManager?.addPublisher(topic: "/turtle1/cmd_vel", messageType: "geometry_msgs/Twist", messageClass: TwistMessage.self)
        turtleSubscriber = turtleManager?.addSubscriber(topic: "/turtle1/pose", messageClass: PoseMessage.self, response: { (message) -> (Void) in
            // update the view with message data
            self.updateWithMessage(message as! PoseMessage)
        })
        turtleSubscriber?.messageType = "turtlesim/Pose"
        
        // if the socket host is empty, present the option to enter the value
        if socketHost == nil {
            onHostButton()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSettings() {
        let defaults = UserDefaults.standard
        socketHost = defaults.string(forKey: "socket_host")
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(socketHost, forKey: "socket_host")
    }
    
    @objc func onResetButton() {
        // reset the turtle sim with a service call
        let serviceCall = turtleManager?.makeServiceCall(service: "/turtlesim/reset")
        serviceCall?.send(nil)
    }
    
    @objc func onHostButton() {
        // change the host used by the websocket
        let alertController = UIAlertController(title: "Enter socket host", message: "IP or name of ROS master", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "Host"
            textField.text = self.socketHost
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            if let textField = alertController.textFields?.first {
                self.socketHost = textField.text
                self.saveSettings()
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func managerDidConnect(_ manager: RBSManager) {
        updateButtonStates(true)
        updateToolbarItems()
    }
    
    func managerDidTimeout(_ manager: RBSManager) {
        updateButtonStates(false)
        print("connection did timeout")
    }
    
    func manager(_ manager: RBSManager, didDisconnect error: Error?) {
        updateButtonStates(false)
        updateToolbarItems()
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
            let redColor = UIColor(red: 0.729, green: 0.131, blue: 0.144, alpha: 1.0)
            connectButton.backgroundColor = redColor
            connectButton.setTitle("DISCONNECT", for: .normal)
        } else {
            let greenColor = UIColor(red: 0.329, green: 0.729, blue: 0.273, alpha: 1.0)
            connectButton.backgroundColor = greenColor
            connectButton.setTitle("CONNECT", for: .normal)
        }
    }
    
    func updateWithMessage(_ message: PoseMessage) {
        turtleXLabel.text = String(describing: message.x ?? 0)
        turtleYLabel.text = String(describing: message.y ?? 0)
        turtleThetaLabel.text = String(describing: message.theta ?? 0)
    }
    
    func updateToolbarItems() {
        if turtleManager?.connected == true {
            toolbar.setItems([resetButton!, flexibleToolbarSpace!, hostButton!], animated: false)
        } else {
            toolbar.setItems([flexibleToolbarSpace!, hostButton!], animated: false)
        }
    }
}

