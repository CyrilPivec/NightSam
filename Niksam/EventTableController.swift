//
//  EventController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 10/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EventTableController {
    var data = [Event]()
    
    init() {}
    
    func loadEvent(success: @escaping () -> Void) {
        getAllEvent(success: { json in
            for (_, e):(String, JSON) in json {
                self.data.append(Event(json: e))
            }
            success()
        })
    }
    
    func getAllEvent(success: @escaping (JSON) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Accept": "application/json"
        ]
        Alamofire.request(baseAPIUrl + "/event", method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to get events")
            } else {
                print("succcess to get events")
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                success(json)
            }
        }
    }
}
