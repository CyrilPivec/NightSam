//
//  EventData.swift
//  Niksam
//
//  Created by Cyril PIVEC on 10/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import SwiftyJSON

class Event {
    
    var json: JSON
    
    var _id: String {
        guard let _id = json["_id"].string else { return "" }
        return _id
    }
    
    var id: Int {
        guard let id = json["id"].int else { return 0 }
        return id
    }
    
    var title: String {
        guard let title = json["title"].string else { return "" }
        return title
    }
    
    var mainPhoto: String {
        guard let mainPhoto = json["mainPhoto"].string else { return "" }
        let url = baseUrl + mainPhoto
        return url
    }
    
    // ajouter photos
    
   
    
    
    var description: String {
        guard let description = json["description"].string else { return "" }
        return description
    }
    
    var shortDescription: String {
        guard let shortDescription = json["shortDescription"].string else { return "" }
        return shortDescription
    }
    
    var date: String {
        guard let date = json["date"].string else { return "" }
        return date
    }
    
    var createdAt: String {
        guard let date = json["createdAt"].string else { return "" }
        return date
    }
    
    var lat: Double {
        guard let lat = json["addressId"]["lat"].double else { return 0 }
        return lat
    }
    
    var lng: Double {
        guard let lng = json["addressId"]["lng"].double else { return 0 }
        return lng
    }
    
    var participants: JSON {
        var parti = JSON()
        parti = json["participants"]
        return parti
    }
    
    var city: String {
        guard let lng = json["addressId"]["city"].string else { return "" }
        return lng
    }
    
    var price: Int {
        guard let price = json["cost"]["price"].int else { return 0 }
        return price
    }
    
    init(json: JSON) {
        self.json = json
    }
}

class SingleEvent {
    var _id = String()
    var title = String()
    var mainPhoto = String()
    var description = String()
    var dateStart = String()
    var price = Int()
    var adresse = String()
    var zip = Int()
    var city = String()
    var country = String()
    var photos = [String]()
    var participants = JSON()
    
    func initialisation(json: JSON) {
        _id = json["_id"].string!
        title = json["title"].string!
        let str = json["mainPhoto"].string!
        mainPhoto = baseUrl + str
        description = json["description"].string!
        dateStart = json["dateStart"].string!
        price = json["cost"].int!
        
        adresse = json["addressId"]["address"].string!
        zip = json["addressId"]["zip"].int!
        city = json["addressId"]["city"].string!
        country = json["addressId"]["country"].string!
        
        let images = json["photos"].array
        
        if (images != nil) {
            for image in images! {
                self.photos.append(String(describing: image))
            }
        }
        
        participants = json["participants"]
    }
    
    

}
