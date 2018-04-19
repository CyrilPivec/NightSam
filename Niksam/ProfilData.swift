//
//  ProfilData.swift
//  Niksam
//
//  Created by Cyril PIVEC on 17/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Profil {
    
    var id = String()
    var email = String()
    var username = String()
    var firstname = String()
    var lastname = String()
    var age = Int()
    var mobile = String()
    var sex = String()
    var description = String()
    var samId = String()
    var permit = String()
    var createdAt = String()
    var avatar = String()
    var background = String()
    
    func initialisation(json: JSON)
    {
        id = json["_id"].string!
        email = json["email"].string!
        username = json["username"].string!
        if json["firstname"].string != nil {
            firstname = json["firstname"].string!
        }
        if json["lastname"].string != nil {
            lastname = json["lastname"].string!
        }
        if json["age"].int != nil {
            age = json["age"].int!
        }
        mobile = json["mobile"].string!
        sex = json["sex"].string!
        if json["description"].string != nil {
            description = json["description"].string!
        }
        if json["samId"].string != nil {
            samId = json["samId"].string!
        }
        if json["permit"].string != nil {
        permit = json["permit"].string!
        }
        createdAt = json["createdAt"].string!
        let url = json["avatar"].string!
        avatar = baseUrl + url
        let url2 = json["background"].string!
        background = baseUrl + url2
    }
    
}

class ProfilPro {
    
    var id = String()
    var email = String()
    var username = String()
    var name = String()
    var telephone = String()
    var mobile = String()
    var description = String()
    var createdAt = String()
    var avatar = String()
    var background = String()
    var adresse = String()
    var zip = Int()
    var city = String()
    var country = String()
    
    func initialisation(json: JSON)
    {
        id = json["_id"].string!
        email = json["email"].string!
        username = json["username"].string!
        if json["name"].string != nil {
            name = json["name"].string!
        }
        if json["telephone"].string != nil {
            telephone = json["telephone"].string!
        }
        if json["mobile"].string != nil {
            mobile = json["mobile"].string!
        }
        if json["description"].string != nil {
            description = json["description"].string!
        }
        createdAt = json["createdAt"].string!
        let url = json["avatar"].string!
        avatar = baseUrl + url
        let url2 = json["background"].string!
        background = baseUrl + url2
        
        
        print("top1")
        adresse = json["addressId"]["address"].string!
        print("top2")
        zip = json["addressId"]["zip"].int!
        print("top3")
        city = json["addressId"]["city"].string!
        print("top4")
        country = json["addressId"]["country"].string!
        print("top5")
    }
    
}

