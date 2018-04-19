//
//  SamController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 24/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SamController {
    
    func encode64image(image: UIImage) -> String {
        let userImage:UIImage = image
        let imageData:NSData = UIImagePNGRepresentation(userImage)! as NSData
        let strBase64 = imageData.base64EncodedString()
        
        return "data:image/jpeg;base64," + strBase64
    }
    
    func beSam(image: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "photo": image
        ]
        
        print(parameters)
        
        Alamofire.request(baseAPIUrl + "/user/permit", method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to put picture")
            } else {
                print("succcess to put picture")
                success()
            }
        }
    }

}
