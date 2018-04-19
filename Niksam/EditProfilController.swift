//
//  EditProfilController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 26/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class EditProfilController {
    
    func encode64image(image: UIImage) -> String {
        let userImage:UIImage = image
        let imageData:NSData = UIImagePNGRepresentation(userImage)! as NSData
        let strBase64 = imageData.base64EncodedString()
        
        return "data:image/jpeg;base64," + strBase64
    }
    
    func editAvatarUser(image: String, success: @escaping () -> Void) {
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
        
        Alamofire.request(baseAPIUrl + "/user/avatar", method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to put picture")
            } else {
                print("succcess to put picture")
                /*guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                print(resp)*/
                success()
            }
        }
    }
    
    func editBackgroundUser(image: String, success: @escaping () -> Void) {
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
        
        Alamofire.request(baseAPIUrl + "/user/background", method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to put background")
            } else {
                print("succcess to put background")
                success()
            }
        }
    }
    
    func editUser(email: String, username: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "email": email,
            "username": username
        ]
        
        Alamofire.request(baseAPIUrl + "/user", method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to edit profile")
            } else {
                print("succcess to edit profile")
                success()
            }
        }
    }
    
    func editPro(email: String, name: String, address: String, zip: String, city: String, country: String, success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        let parameters: Parameters = [
            "email": email,
            "name": name,
            "address": address,
            "zip": zip,
            "city": city,
            "country": country,
            "lat": 48.695710,
            "lng": 6.189895
        ]
        
        Alamofire.request(baseAPIUrl + "/pro", method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to edit profile")
            } else {
                print("succcess to edit profile")
                success()
            }
        }
    }
    
    func editAvatarPro(image: String, success: @escaping () -> Void) {
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
        
        Alamofire.request(baseAPIUrl + "/pro/avatar", method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to put avatar")
            } else {
                print("succcess to put avatar")
                success()
            }
        }
    }
    
    func editBackgroundPro(image: String, success: @escaping () -> Void) {
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
        
        Alamofire.request(baseAPIUrl + "/pro/background", method: .put, parameters: parameters, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to put background")
            } else {
                print("succcess to put background")
                success()
            }
        }
    }
    
}
