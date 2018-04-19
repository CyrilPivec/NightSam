//
//  ProfilController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 10/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfilController {
    var _profil = Profil()
    var _profilPro = ProfilPro()
    
    func getUser(success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        Alamofire.request(baseAPIUrl + "/user", method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to get profil")
            } else {
                print("succcess to get profil")
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                self._profil.initialisation(json: json)
                
                success()
            }
        }
    }
    
    func getPro(success: @escaping () -> Void) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        Alamofire.request(baseAPIUrl + "/pro", method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to get profil")
            } else {
                print("succcess to get profil")
                guard let value = response.result.value else {
                    return
                }
                let json = JSON(value)["result"]
                self._profilPro.initialisation(json: json)
                
                success()
            }
        }
    }

}
