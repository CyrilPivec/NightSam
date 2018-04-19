//
//  SocketIOManager.swift
//  Niksam
//
//  Created by Cyril PIVEC on 12/10/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import SocketIO
import SwiftyJSON

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    let socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: baseUrl)! as URL)
    
    override init() {
        super.init()
    }
    
    func enterChat(eventId: String) {
        guard let username = UserDefaults.standard.value(forKey: "username") as? String,
        let avatar = UserDefaults.standard.value(forKey: "avatar") as? String,
        let userId = UserDefaults.standard.value(forKey: "_id") as? String,
        let pro = UserDefaults.standard.value(forKey: "ispro") as? Bool
        else {
            print("erreur 401")
            return
        }
        let param: [String : Any] = [
            "username": username,
            "userId": userId,
            "eventId": eventId,
            "isPro": pro,
            "avatar": avatar
            ]
        socket.emit("addUser", param)
    }
    
    func sendMessage(msg: String) {
        socket.emit("sendChat", msg)
    }
    
    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: AnyObject]) -> Void) {
        socket.on("updateChat") { (dataArray, socketAck) -> Void in
            let data = dataArray[0] as! [String: AnyObject]
            completionHandler(data)
        }
    }
    
    func quitChat() {
        socket.emit("quit chat")
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}

