//
//  SingleEventController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 29/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SingleEventController {
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
                success()
            }
        }
    }
    
    func deleteEvent(_id: String, success: @escaping () -> Void) {
        
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        Alamofire.request(baseAPIUrl + "/pro/event/" + _id, method: .delete, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to delete event")
            } else {
                print("succcess to delete event")
               /* guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]*/
                success()
            }
        }
    }
    
    func encode64image(image: UIImage) -> String {
        let userImage:UIImage = image
        let imageData:NSData = UIImagePNGRepresentation(userImage)! as NSData
        let strBase64 = imageData.base64EncodedString()
        
        return "data:image/jpeg;base64," + strBase64
    }
    
    func addImage(_id: String, _image: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "photo": _image
        ]
        
        Alamofire.request(baseAPIUrl + "/pro/event/" + _id + "/photo" , method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to add picture")
            } else {
                print("succcess to add picture")
                /*guard let value = response.result.value else {
                 return
                 }
                 let json = JSON(value)["result"]
                 print(resp)*/
                success()
            }
        }
    }

}
