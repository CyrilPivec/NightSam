//
//  CommentData.swift
//  Niksam
//
//  Created by Cyril PIVEC on 03/07/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Comment {
    
    var json: JSON
    
    var _id: String {
        guard let _id = json["_id"].string else { return "" }
        return _id
    }
    
    var userId: String {
        guard let userid = json["userId"].string else { return "" }
        return userid
    }
    
    var eventId: String {
        guard let eventid = json["eventId"].string else { return "" }
        return eventid
    }

    var note: Int {
        guard let note = json["rate"].int else { return 0 }
        return note
    }

    var comment: String {
        guard let comment = json["comment"].string else { return "" }
        return comment
    }
    
    var createdAt: String {
        guard let createdAt = json["createdAt"].string else { return "" }
        return createdAt
    }
    
    init(json: JSON) {
        self.json = json
    }
}
