//
//  showSamController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 06/09/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class showSamController {
    func getSeatSam(_id: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        Alamofire.request(baseAPIUrl + "/sam/" + _id, method: .put, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to get seat sam")
            } else {
                print("succcess to get seat sam")
                success()
            }
        }
    }
    
    func postComment(_id: String, success: @escaping () -> Void, note: String, commentaire: String) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "samId": _id,
            "rate": note,
            "comment": commentaire
        ]
        
        print(parameters)
        
        Alamofire.request(baseAPIUrl + "/sam/comment", method: .post, parameters: parameters, headers: headers).responseJSON { response in
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
