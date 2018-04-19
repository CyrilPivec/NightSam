//
//  EditEventController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 30/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EditEventController {
    
    func encode64image(image: UIImage) -> String {
        let userImage:UIImage = image
        let imageData:NSData = UIImagePNGRepresentation(userImage)! as NSData
        let strBase64 = imageData.base64EncodedString()
        
        return "data:image/jpeg;base64," + strBase64
    }
    
    func editEvent(_id: String, title: String, description: String, mainPhoto: String, dateStart: Date, dateEnd: Date, cost: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "title": title,
            "dateStart": dateStart.iso8601,
            "dateEnd": dateEnd.iso8601,
            "mainPhoto": mainPhoto,
            "description": description,
            "cost": cost
        ]
        
        Alamofire.request(baseAPIUrl + "/pro/event/" + _id , method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to edit profile")
            } else {
                print("succcess to edit profile")
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
