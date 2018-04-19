//
//  LoginController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 08/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginController {
    
    func DoLogin(_email:String, _psw:String, success: @escaping() -> Void, failure: @escaping() -> Void, failureEmail: @escaping() -> Void, failurePswd: @escaping() -> Void) {
        let param = ["email": _email, "password": _psw]
        
        Alamofire.request(baseAPIUrl + "/login", method: .post, parameters: param).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print("failed to login")
                if resp.statusCode == 404 {
                    failureEmail()
                }
                if resp.statusCode == 409 {
                    failurePswd()
                } else {
                    failure()
                }
            } else {
                print("succcess to login")
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                let defaults = UserDefaults.standard
                defaults.set(_email, forKey:"StorredEmail")
                defaults.set(12, forKey:"kmaffichage")
                defaults.set(_psw, forKey:"StorredPassword")
                defaults.set(json["_id"].string!, forKey:"_id")
                
                defaults.set(json["username"].string!, forKey:"username")
                defaults.set(json["avatar"].string!, forKey:"avatar")
                defaults.set(json["background"].string!, forKey:"background")
                defaults.set(json["token"].string!, forKey:"token")
                
                let ispro = JSON(value)["isPro"].bool
                defaults.set(ispro, forKey:"ispro")
                success()
            }
        }
    }
}
