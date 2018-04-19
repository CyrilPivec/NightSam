//
//  SamEventController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 26/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SamEventController {
    var data = [Participant]()
    
    init() {}
    
    func loadSam(_id : String, success: @escaping () -> Void) {
        getAllSam(_id: _id, success: { json in
            for (_, e):(String, JSON) in json {
                self.data.append(Participant(json: e))
            }
            success()
        })
    }
    
    func getAllSam(_id : String, success: @escaping (JSON) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Accept": "application/json"
        ]
        Alamofire.request(baseAPIUrl + "/event/" + _id + "/sams" , method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(_id)
                print(resp)
                print("failed to get sams")
            } else {
                print("succcess to get sams")
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
