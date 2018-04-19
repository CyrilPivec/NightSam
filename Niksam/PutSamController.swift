//
//  PutSamController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 26/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PutSamController {
    
    func putSam(_eventid: String, success: @escaping () -> Void, leaveAt: Date, seat: String, radius: String, echec: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        
        
        let parameters: Parameters = [
            "leaveAt": leaveAt.iso8601,
            "seat": Int(seat)!,
            "radius": Int(radius)!
         ]
        
        print(parameters)
        
        Alamofire.request(baseAPIUrl + "/sam/event/" + _eventid, method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                echec()
                print("failed to put participation")
            } else {
                print("succcess to put participation")
                success()
            }
        }
    }
    
}
