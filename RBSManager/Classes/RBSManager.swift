//
//  RBSManager.swift
//  Pods
//
//  Created by Wes Goodhoofd on 2018-01-06.
//

import UIKit
import Starscream
import ObjectMapper

private let _sharedManager = RBSManager()

protocol RBSManagerDelegate {
    func manager(_ manager: RBSManager, didDisconnect: Error)
}

class RBSManager: NSObject, WebSocketDelegate {
    var socket: WebSocket!
    var delegate: RBSManagerDelegate?
    var socketAddress: String?
    
    // ROS handling
    var publishers: [RBSPublisher]
    var subscribers: [RBSSubscriber]
    var serviceCalls: [RBSServiceCall]
    
    class func sharedManager() -> RBSManager {
        return _sharedManager
    }
    
    fileprivate override init() {
        publishers = [RBSPublisher]()
        subscribers = [RBSSubscriber]()
        serviceCalls = [RBSServiceCall]()
    }
    
    func connect(address: String) throws {
        // validate the address
        var addressString = address
        if !addressString.starts(with: "ws://") {
            addressString = "ws://"+addressString
        }
        socketAddress = addressString
        
        if let url = URL(string: addressString) {
            socket = WebSocket(url: url)
            socket.delegate = self
            socket.connect()
        } else {
            throw "Requested websocket URL is invalid"
        }
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    /// Convert an object to JSON and send through the socket
    func sendData(object: Mappable) {
        
    }
    
    /// Convert a dictionary to JSON and send through the socket
    func sendData(dictionary: [String : String]) {
        
    }
    
    /// Send a JSON string through the socket
    func sendData(JSON: String) {
        
    }
    
    // MARK: WebSocket delegate methods
    func websocketDidConnect(socket: WebSocketClient) {
        
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
}

// MARK: Extensions
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
