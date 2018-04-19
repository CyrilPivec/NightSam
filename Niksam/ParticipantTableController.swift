//
//  ParticipantTableController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 25/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ParticipantTableController {
    var data = [Participant2]()
    
    init() {}
    
    func loadParticipant(_id : String, success: @escaping () -> Void) {
        getAllParticipant(_id: _id, success: { json in
            for (_, e):(String, JSON) in json {
                self.data.append(Participant2(json: e))
            }
            success()
        })
    }
    
    func getAllParticipant(_id : String, success: @escaping (JSON) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Accept": "application/json"
        ]
        Alamofire.request(baseAPIUrl + "/event/" + _id + "/users" , method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(_id)
                print(resp)
                print("failed to get participants")
            } else {
                print("succcess to get participants")
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                print(json)
                success(json)
            }
        }
    }

}
