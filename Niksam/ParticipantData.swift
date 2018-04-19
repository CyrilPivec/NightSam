//
//  ParticipantData.swift
//  Niksam
//
//  Created by Cyril PIVEC on 25/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Participant {
    var json: JSON
    
    var userid: String {
        guard let id = json["userid"].string else { return "" }
        return id
    }
    
    var _id: String {
        guard let id = json["_id"].string else { return "" }
        return id
    }
    
    var seat: Int {
        guard let seat = json["seat"].int else { return 0 }
        return seat
    }
    
    var username: String {
        guard let id = json["username"].string else { return "" }
        return id
    }
    
    var avatar: String {
        guard let avatar = json["avatar"].string else { return "" }
        let url = baseUrl + avatar
        return url
    }
    
    var radius: Int {
        guard let id = json["radius"].int else { return 0 }
        return id
    }
    
    var rate: Int {
        guard let id = json["rate"].int else { return 0 }
        return id
    }
    
    var leaveAt: String {
        guard let id = json["leaveAt"].string else { return "" }
        return id
    }
    
    var passengers: JSON {
        return json["passengers"]
    }

    init(json: JSON) {
        self.json = json
    }
}

class Participant2 {
    var json: JSON
    
    var _id: String {
        guard let id = json["_id"].string else { return "" }
        return id
    }
    
    var username: String {
        guard let id = json["username"].string else { return "" }
        return id
    }
    
    var avatar: String {
        guard let avatar = json["avatar"].string else { return "" }
        let url = baseUrl + avatar
        return url
    }
    
    var age: String {
        guard let id = json["age"].string else { return "" }
        return id
    }
    
    var sex: String {
        guard let id = json["sex"].string else { return "" }
        return id
    }
    
    init(json: JSON) {
        self.json = json
    }
}
