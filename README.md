# RBSManager

[![Version](https://img.shields.io/cocoapods/v/RBSManager.svg?style=flat)](http://cocoapods.org/pods/RBSManager)
[![License](https://img.shields.io/cocoapods/l/RBSManager.svg?style=flat)](http://cocoapods.org/pods/RBSManager)
[![Platform](https://img.shields.io/cocoapods/p/RBSManager.svg?style=flat)](http://cocoapods.org/pods/RBSManager)

A Swift-native library for handling the WebSocket connection to a [Robot Operating System](http://www.ros.org) (ROS) master running ROSBridge. Control your robots with a mobile phone.

It is largely a drop-in replacement to my earlier Objective-C library, [RBManager](https://github.com/wesgood/RBManager). *Fun fact, the extra S stands for Swift.*

RBSManager provides a wrapper for the different ROS functionality calls:

* [Subscribers](#subscribers)
* [Publishers](#publishers)
* [Service Calls](#service-calls)

## Dependencies
RBSManager uses the following Github components, installed with the CocoaPod:
* [Starscream](https://github.com/daltoniam/starscream) -- a Swift native Websocket library
* [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper) -- a tool to translate JSON data into Swift objects (used by the ROS message system)

Thank you to their developers!

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first. The example project connects to the Turtlesim node and provides the following operations:
* demonstrate a subscriber to display X, Y and Theta state of the turtle
* rotate a turtle icon to show how the theta value changes
* control a turtle using left, right, up, down buttons to demonstrate publishing a message
* reset the turtlesim using a service call demonstration
* accept dynamic host values
* configure the background using a custom modal colour picker and set parameter service calls
* teleport a turtle with an alert view and service calls using a message object
* click multiple directions simultaneously (easier on a device) to properly steer the turtle around

## Requirements

* iOS 10+
* Swift 3+
* ROS master running a [ROSBridge server](http://wiki.ros.org/rosbridge_suite)
* A valid Apple developer account if you want to test on an actual device

## Installation

RBSManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RBSManager'
```

## Usage

As mentioned the library itself behaves very similar to RBManager. It contains a singleton object so that only instance of the manager is needed -- `RBSManager.sharedManager()`

### Delegate
The manager will post events to the following methods at various points:
```
func manager(_ manager: RBSManager, didDisconnect error: Error?)
func managerDidConnect(_ manager: RBSManager)
func manager(_ manager: RBSManager, threwError error: Error)
```
The error objects will either be forwarded from the socket itself or be related to manager functionality. The error description will include info about what went wrong.

All delegate calls are done on the main UI thread. Processing and JSON handling are done on a background thread to avoid locking the interface.

### Messages
Messages are the core ROS component and RBSManager implements the `Mappable` protocol to handle them. There are currently a small number of messages included in the library and more will be added in the future (I had to select which ones I felt were most important). Custom messages can be added as long as they inherit from `RBSMessage` and properly follow the `Mappable` protocol.

Messages should generally have foundation object types like Float64 and String but can also handle nested RBSMessage types. The catch is that nested objects need additional setup to handle the init methods in place. View the `TwistMessage` type to see how that works.

The way that Swift works meant some compromises with the overall message system (mostly relating to object types and casting) so I hope to review it and improve over time.

### Subscribers
Create a new subscriber by calling the following method on the manager:
```
func addSubscriber(topic: String, messageClass: RBSMessage.Type, response: @escaping ((_ message: RBSMessage) -> (Void))) -> RBSSubscriber
```
* topic -- the ROS node to subscribe to
* messageClass -- the type declaration of the message to receive (eg. use `TwistMessage.self`)
* response -- a callback to receive the message

Example:
```
let turtleSubscriber = turtleManager?.addSubscriber(topic: "/turtle1/pose", messageClass: PoseMessage.self, response: { (message) -> (Void) in
    // update the view with message data
    self.updateWithMessage(message as! PoseMessage)
})
```
As a change from the delegate pattern of `RBManager` , the callback structure maintains a more Swift-like process and better allows multiple subscribers on the same topic. The subscriber object also exposes most options available to ROS, like queue length and throttle rate.

A subscriber will auto subscribe when the manager connects but you can connect/disconnect manually by calling `.subscribe()` or `.unsubscribe()` respectively.

### Publishers
Create a new publisher by calling the following method on the manager:
```
func addPublisher(topic: String, messageType: String, messageClass: RBSMessage.Type) -> RBSPublisher
```
* topic -- the ROS node to publish to
* messageType -- the type of message ROS is expecting (eg. `geometry_msgs/Twist`)
* messageClass -- the class type that you will be sending (eg. `TwistMessage.self`)

Example
```
let turtlePublisher = turtleManager?.addPublisher(topic: "/turtle1/cmd_vel", messageType: "geometry_msgs/Twist", messageClass: TwistMessage.self)
```

Create a new message object separately and publish it by passing the message object to `.publish(_ message: RBSMessage)`

A publisher is  advertised when the manager connects but you can manually change it's state by calling `.advertise()` or `.unadvertise()`

### Service calls
Service calls are made to perform an operation on ROS, with or without parameters and a response value. Create a new service call by using the following method on the manager:
```
func makeServiceCall(service: String) -> RBSServiceCall
```
* service -- the ROS topic/node to make the request with

Example
```
let serviceCall = turtleManager?.makeServiceCall(service: "/reset")
```
The service call can be triggered by calling `.send(_ response: ((_ data: [String : Any]) -> (Void))?)`. That optional response callback can receive the service call response and return a dictionary of data.

To pass data to the service call itself, assign data to one of: dataArgument (dictionary), messageArgument (an RBSMessage object) or arrayArgument (array)

### Parameters
The manager can also handle setting and getting ROS parameters by generating a service call object with preformatted properties.
```
func getParam(name: String) -> RBSServiceCall
func setParam(name: String, value: Any) -> RBSServiceCall
```
Use the regular send callback to receive data.

## Tools
### Custom message generator
As a convenience, I've included a Python script to generate Swift message files. It isn't perfect, but will do most of the work necessary for the messages to compile. It is located in the Tools folder.

```
python ./custom_messages.py [class name] [variables...n]
```

where

* [class name] = the name of the file/class (should include Message for consistency)
* [variables...n] = variable name and Swift type, separated by colon

Example:
```
python ./custom_messages.py ExampleMessage stringData:String floatData:Float intData:Int
```


## Roadmap
This library changes a lot of things from my previous work and will definitely be in progress for some time. Please take that caveat into account when building a project and reach out to me if there is a feature you think the library is missing.

* populate all standard ROS message types
* improve the handling of multiple subscribers/publishers by generating random IDs if not provided

## Author

wesgood, w [at] wesg [dot] ca, @wesgood

*Mobile software developer, mechatronics engineer, robot enthusiast.*

## License

RBSManager is available under the MIT license. See the LICENSE file for more info.

TL;DR; Please do lots of cool things with my library, but share them with me so I can see what it's being used for. Even better, include a link or acknowledgement of the library in your project.
