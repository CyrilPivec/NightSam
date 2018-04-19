//
//  ChatController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 11/10/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ChatController {
//    var messages = [Message]()
    var messages = [ChatInfo]()
    
    func getPreviousMessage(_id: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        Alamofire.request(baseUrl + "/chat/" + _id, method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to get previous messages")
            } else {
                guard let value = response.result.value else { return }
                let json = JSON(value)["result"]
                for (_, j) in json {
                    let msg = j["body"].string!
                    let sender = j["author"]["username"].string!
                    let isPro = j["author"]["isPro"].bool!
                    let createdAt = j["createdAt"].string!
                    let info = ChatInfo(sender: sender, isPro: isPro, msg: msg, createdAt: createdAt)
                    self.messages.append(info)
                }
                success()
            }
        }
    }
}

struct ChatInfo {
    var sender: String
    var isPro: Bool
    var msg: String
    var createdAt: String
}

class Message {
    var eventId: String
    var body: String
    var userId: String
    var username: String
    var avatar: String
    var isPro: Bool
    var createdAt: String
    
    init(json: JSON) {
        eventId = json["eventId"].string!
        body = json["body"].string!
        createdAt = json["createdAt"].string!
        let author = json["author"]
        userId = author["userId"].string!
        username = author["username"].string!
        avatar = author["avatar"].string!
        isPro = author["isPro"].bool!
    }
}
