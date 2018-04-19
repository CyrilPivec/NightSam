//
//  EventController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 25/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EventController {
    var _event = SingleEvent()
    
    func getEvent(_id: String, success: @escaping () -> Void) {
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        Alamofire.request(baseAPIUrl + "/event/" + _id, method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to get event")
            } else {
                print("succcess to get event")
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                self._event.initialisation(json: json)
                print(json)
                success()
            }
        }
    }
    
    func putParticipation(_eventid: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        Alamofire.request(baseAPIUrl + "/user/event/" + _eventid, method: .put, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to put participation")
            } else {
                print("succcess to put participation")
                success()
            }
        }
    }
    
}
