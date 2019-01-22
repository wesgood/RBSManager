//
//  ViewController.swift
//  RBSManager
//
//  Created by wesgood on 01/06/2018.
//  Copyright (c) 2018 wesgood. All rights reserved.
//

import UIKit
import RBSManager

class ViewController: UIViewController, RBSManagerDelegate, ColorPickerDelegate {
    // user interface
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet var leftButton: UIButton!
    @IBOutlet var upButton: UIButton!
    @IBOutlet var rightButton: UIButton!
    @IBOutlet var downButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var backgroundButton: UIButton!
    @IBOutlet var teleportButton: UIButton!
    var hostButton: UIBarButtonItem?
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
    var lastPoseMessage: PoseMessage!
    
    // data handling
    let linearSpeed: Float64 = 1.25
    let angularSpeed: Float64 = Float64.pi/3
    var redColour: Float64?
    var greenColour: Float64?
    var blueColour: Float64?
    
    // sending message timer
    var controlTimer: Timer?
    
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
        hostButton = UIBarButtonItem(title: "Host", style: .plain, target: self, action: #selector(onHostButton))
        flexibleToolbarSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        updateToolbarItems()
        
        // create the publisher and subscriber
        turtlePublisher = turtleManager?.addPublisher(topic: "/turtle1/cmd_vel", messageType: "geometry_msgs/Twist", messageClass: TwistMessage.self)
        turtleSubscriber = turtleManager?.addSubscriber(topic: "/turtle1/pose", messageClass: PoseMessage.self, response: { (message) -> (Void) in
            // store the message for other operations
            self.lastPoseMessage = message as! PoseMessage
            
            // update the view with message data
            self.updateWithMessage(self.lastPoseMessage)
        })
        turtleSubscriber?.messageType = "turtlesim/Pose"
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
    
    @objc func onHostButton() {
        // change the host used by the websocket
        let alertController = UIAlertController(title: "Enter socket host", message: "IP or name of ROS master", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "Host"
            textField.text = self.socketHost
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
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
        
        // retrieve the colours used by the background
        retrieveColourParameters()
    }
    
    func manager(_ manager: RBSManager, threwError error: Error) {
        if (manager.connected == false) {
            updateButtonStates(false)
        }
        print(error.localizedDescription)
    }
    
    func manager(_ manager: RBSManager, didDisconnect error: Error?) {
        updateButtonStates(false)
        updateToolbarItems()
        print(error?.localizedDescription ?? "connection did disconnect")
    }
    
    func retrieveColourParameters() {
        // request the colour parameters
        let redServiceCall = turtleManager?.getParam(name : "background_r")
        redServiceCall?.serviceId = "red"
        redServiceCall?.send({ (data) -> (Void) in
            self.redColour = Float64(data["value"] as! String)
        })
        
        let greenServiceCall = turtleManager?.getParam(name : "background_g")
        greenServiceCall?.serviceId = "green"
        greenServiceCall?.send({ (data) -> (Void) in
            self.greenColour = Float64(data["value"] as! String)
        })
        
        let blueServiceCall = turtleManager?.getParam(name : "background_b")
        blueServiceCall?.serviceId = "blue"
        blueServiceCall?.send({ (data) -> (Void) in
            self.blueColour = Float64(data["value"] as! String)
        })
    }
    
    @IBAction func onDirectionButtonUp(_ button: UIButton) {
        // build the message based on the button tapped
        if allButtonsInactive() {
            controlTimer?.invalidate()
            controlTimer = nil
        }
        sendTwistMessage()
    }
    
    @objc func sendTwistMessage() {
        let message = TwistMessage()
        if upButton.isHighlighted {
            message.linear?.x = linearSpeed
        } else if downButton.isHighlighted {
            message.linear?.x = -linearSpeed
        }
        
        if leftButton.isHighlighted {
            message.angular?.z = angularSpeed
        } else if rightButton.isHighlighted {
            message.angular?.z = -angularSpeed
        }
        
        // send the message with the publisher
        turtlePublisher?.publish(message)        
    }
    
    @IBAction func onDirectionButtonDown(_ button: UIButton) {
        // trigger the timer to start sending message
        if controlTimer == nil {
            controlTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self, selector: #selector(sendTwistMessage), userInfo: nil, repeats: true)
        }
        sendTwistMessage()
    }
    
    
    func directionButtonIsActive() -> Bool {
        if leftButton.isHighlighted || rightButton.isHighlighted || upButton.isHighlighted || downButton.isHighlighted {
            return true
        }
        return false
    }
    
    func allButtonsInactive() -> Bool {
        if leftButton.isHighlighted || rightButton.isHighlighted || upButton.isHighlighted || downButton.isHighlighted {
            return false
        }
        return true
    }

    @IBAction func onConnectButton() {
        if turtleManager?.connected == true {
            turtleManager?.disconnect()
        } else {
            if socketHost != nil {
                // the manager will produce a delegate error if the socket host is invalid
                turtleManager?.connect(address: socketHost!)
            } else {
                // print log error
                print("Missing socket host value --> use host button")
            }
        }
    }
    
    @IBAction func onResetButton() {
        // reset the turtle sim with a service call
        let serviceCall = turtleManager?.makeServiceCall(service: "/reset")
        serviceCall?.send(nil)
    }
    
    @IBAction func onTeleportButton() {
        // send a service call to move the turtle to some point
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        
        let alertController = UIAlertController(title: "Teleport", message: "Select the X and Y coordinates to teleport the turtle", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "X"
            if let x = self.lastPoseMessage.x {
                textField.text = numberFormatter.string(for: x)
            }
            textField.keyboardType = .numbersAndPunctuation
        })
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Y"
            if let y = self.lastPoseMessage.y {
                textField.text = numberFormatter.string(for: y)
            }
            textField.keyboardType = .numbersAndPunctuation
        })
        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
            textField.placeholder = "Theta"
            if let theta = self.lastPoseMessage.theta {
                textField.text = numberFormatter.string(for: theta)
            }
            textField.keyboardType = .numbersAndPunctuation
        })
        let confirmAction = UIAlertAction(title: "Send", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            // build the number value
            let x = Float64(alertController.textFields![0].text!)
            let y = Float64(alertController.textFields![1].text!)
            let theta = Float64(alertController.textFields![2].text!)
            
            // send the service call
            self.teleportTurtle(x!, y: y!, theta: theta!)
        })
        alertController.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
        })
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onBackgroundButton() {
        // reset the background colour using parameters, after retrieving the current colour
        var colour = UIColor.black
        if redColour != nil && greenColour != nil && blueColour != nil {
            colour = UIColor(red: CGFloat(redColour!/255.0), green: CGFloat(greenColour!/255.0), blue: CGFloat(blueColour!/255.0), alpha: 1.0)
        }
        
        let colorView = ColorPickerView(colour: colour)
        colorView.colourDelegate = self
        colorView.show()
    }
    
    func didSelectColour(picker: ColorPickerView, colour: UIColor?) {
        if let colourObject = colour {
            let rgbColour = colourObject.cgColor
            if let rgbColours = rgbColour.components {
                let red = Int(rgbColours[0]*255)
                let green = Int(rgbColours[1]*255)
                let blue = Int(rgbColours[2]*255)
                
                let redServiceCall = turtleManager?.setParam(name: "background_r", value: String(describing: red))
                let greenServiceCall = turtleManager?.setParam(name: "background_g", value: String(describing: green))
                let blueServiceCall = turtleManager?.setParam(name: "background_b", value: String(describing: blue))
                let clearServiceCall = turtleManager?.makeServiceCall(service: "/clear")
            
                // batch the service calls together
                turtleManager?.sendMultipleServiceCalls([redServiceCall!, greenServiceCall!, blueServiceCall!, clearServiceCall!])
            }
        }
    }
    
    // send the teleport operation
    func teleportTurtle(_ x: Float64, y: Float64, theta: Float64) {
        // create the message object
        let message = TeleportAbsoluteMessage()
        message.x = x
        message.y = y
        message.theta = theta
        
        // build the service call
        let serviceCall = turtleManager?.makeServiceCall(service: "/turtle1/teleport_absolute")
        
        // assign the message object to the service call
        serviceCall?.messageArgument = message
        
        // send the call without accepting the response (because there is none)
        serviceCall?.send(nil)
    }
    
    // update interface for the different connection statuses
    func updateButtonStates(_ connected: Bool) {
        leftButton.isEnabled = connected
        rightButton.isEnabled = connected
        downButton.isEnabled = connected
        upButton.isEnabled = connected
        resetButton.isEnabled = connected
        teleportButton.isEnabled = connected
        backgroundButton.isEnabled = connected
        
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
        
        // rotate the turtle for fun
        UIView.animate(withDuration: 0.25, animations: {
            // add 90 deg due to the image orientation
            self.turtleIconImage.transform = CGAffineTransform(rotationAngle: -CGFloat(message.theta! - (Float.pi/2)))
        })
    }
    
    func updateToolbarItems() {
        if turtleManager?.connected == true {
            toolbar.setItems([], animated: false)
        } else {
            toolbar.setItems([flexibleToolbarSpace!, hostButton!], animated: false)
        }
    }
}

