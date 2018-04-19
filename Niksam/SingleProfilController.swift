//
//  SingleProfilController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 25/05/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SingleProfilController {
    var _profil = Profil()
    
    func getProfil(success: @escaping () -> Void, _id: String) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("erreur 401")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": token
        ]
        
        print("///////////")
        print(_id)
        print("///////////")
        
        Alamofire.request(baseAPIUrl + "/user/" + _id, method: .get, headers: headers).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                print(resp)
                print("failed to get profil")
            } else {
                print("succcess to get profil")
                guard let value = response.result.value else {
                    return
                }
                print(value)
                let json = JSON(value)["result"]
                print(json)
                self._profil.initialisation(json: json)
                
                success()
            }
        }
    }

}
