//
//  CommenterController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 03/07/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommenterController {
    
    func postComment(_eventid: String, success: @escaping () -> Void, note: String, commentaire: String) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "eventId": _eventid,
            "rate": note,
            "comment": commentaire
        ]
        
        print(parameters)
        
        Alamofire.request(baseAPIUrl + "/comment", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to put commentaire")
            } else {
                print("succcess to put commentaire")
                success()
            }
        }
    }
    
}
