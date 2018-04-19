//
//  CommentTableController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 03/07/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommentTableController {
    var data = [Comment]()
    
    init() {}
    
    func loadEvent(success: @escaping () -> Void, _id: String) {
        getAllComment(success: { json in
            for (_, e):(String, JSON) in json {
                self.data.append(Comment(json: e))
            }
            success()
        }, _id: _id)
    }
    
    func getAllComment(success: @escaping (JSON) -> Void, _id: String) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Accept": "application/json"
        ]
        Alamofire.request(baseAPIUrl + "/comment?eventId=" + _id, method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to get comments")
                print(resp)
            } else {
                print("succcess to get comments")
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                //print(json)
                success(json)
            }
        }
    }
}
