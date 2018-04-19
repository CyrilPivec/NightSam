//
//  RechercheController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 07/11/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RechercheController {
    
    var data = [Event]()
    var data2 = [Participant2]()
    
    init() {}
    
    func loadEvent(success: @escaping () -> Void, keyword: String) {
        getAllEvent(keyword: keyword, success: { json in
            for (_, e):(String, JSON) in json {
                self.data.append(Event(json: e))
            }
            success()
        })
    }
    
    func getAllEvent(keyword: String, success: @escaping (JSON) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "search": keyword
        ]
        Alamofire.request(baseAPIUrl + "/search/event", method: .post, parameters: parameters, headers: headers).responseJSON { response in
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
    
    func loadParticipant(success: @escaping () -> Void, keyword: String) {
        getAllParticipant(keyword: keyword, success: { json in
            for (_, e):(String, JSON) in json {
                self.data2.append(Participant2(json: e))
            }
            success()
        })
    }
    
    func getAllParticipant(keyword: String, success: @escaping (JSON) -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + token,
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "search": keyword
        ]
        Alamofire.request(baseAPIUrl + "/search/user", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to get events")
            } else {
                print("succcess to get user")
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
