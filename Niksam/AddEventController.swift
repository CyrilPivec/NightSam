//
//  AddEventController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 28/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AddEventController {
    
    func encode64image(image: UIImage) -> String {
        let userImage:UIImage = image
        let imageData:NSData = UIImagePNGRepresentation(userImage)! as NSData
        let strBase64 = imageData.base64EncodedString()
        
        return "data:image/jpeg;base64," + strBase64
    }
    
    func addEvent(title: String, description: String, dateStart: Date, dateEnd: Date, image: String, cost: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        /*
        Alamofire.request("https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "+" + city + "," + country + "&key=" + GMApiKey, method: .get).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to get coord")
            } else {
                print("succcess to get coord")
                guard let value = response.result.value else {
                    return
                }
                print("/////")
                print(value)
                print("/////")
            }
        }*/
        
        let parameters: Parameters = [
            "title": title,
            "description": description,
            "dateStart": dateStart.iso8601,
            "dateEnd": dateEnd.iso8601,
            "mainPhoto": image,
            "cost": cost
        ]
        
        print(parameters)
        
        Alamofire.request(baseAPIUrl + "/event", method: .post, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to add event")
            } else {
                print("succcess to add event")
                success()
            }
        }
    }
}
