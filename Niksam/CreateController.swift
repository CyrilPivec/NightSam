//
//  CreateController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 08/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CreateController {
    
    var lat = Int()
    var lng = Int()
    
    func checkAdresse(_country: String, _ville: String, _adresse: String, success: @escaping() -> Void, failure: @escaping() -> Void) {
        
        let country = _country.replacingOccurrences(of: " ", with: "+")
        let ville = _ville.replacingOccurrences(of: " ", with: "+")
        let adresse = _adresse.replacingOccurrences(of: " ", with: "+")
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + adresse + ",+" + ville + ",+" + country + "&key=" + "AIzaSyDVdW57MPmJlil-vjmXPMtM9hNxcyRVLRw"
        
        Alamofire.request(url).responseJSON { response in
            guard let resp = response.response else { return }
                if resp.statusCode != 200 {
                    print(resp)
                    print("bad adresse")
                    
                } else {
                    guard let value = response.result.value else {
                        return
                    }
                    let json = JSON(value)["results"]
                    
                    self.lat = json[0]["geometry"]["location"]["lat"].int!
                    self.lng = json[0]["geometry"]["location"]["lng"].int!
                }
        }
    }
    
    func createUser(_email: String, _password: String, _username: String, _sex: String, _birthday: String, success: @escaping() -> Void, failure: @escaping() -> Void, failureEmail: @escaping() -> Void) {
        
        let param : Parameters = ["email": _email, "password": _password, "username": _username, "sex": _sex, "birthday": _birthday]
        
        Alamofire.request(baseAPIUrl + "/register/user", method: .post, parameters: param).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                if resp.statusCode == 409 {
                    failureEmail()
                } else {
                    failure()
                }
            } else {
                print("succcess to register")
                success()
            }
        }
        
    }
    
    func createPro(_email: String, _password: String, _username: String, _adresse: String, _zip: String, _city: String, _country: String, success: @escaping() -> Void, failure: @escaping() -> Void, failureEmail: @escaping() -> Void) {
        
        let param : Parameters = ["email": _email, "password": _password, "username": _username, "name": _username, "address": _adresse, "zip": _zip, "city": _city, "country": _country, "lat": lat, "lng": lng]
        
        Alamofire.request(baseAPIUrl + "/register/pro", method: .post, parameters: param).responseJSON { response in
            guard let resp = response.response else { return }
            if resp.statusCode != 200 {
                if resp.statusCode == 409 {
                    failureEmail()
                } else {
                    failure()
                }
            } else {
                success()
            }
        }
    }
    
}
