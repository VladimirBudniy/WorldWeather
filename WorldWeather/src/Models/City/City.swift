//
//  City.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/15/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Firebase

struct City {
    var name: String?
    var id: Int?
    var lon: Double?
    var lat: Double?
    var currentWeather: Weather?
    var forecastWeather: [Weather]?
    var ref: FIRDatabaseReference
}

extension City {
    static func createFrom(snapshot: FIRDataSnapshot) -> City {
        let weatherSnapshot = snapshot.childSnapshot(forPath: "currentWeather")
        let currentWeather = Weather.createFrom(snapshot: weatherSnapshot)
        
        let value = snapshot.value as? NSDictionary
        let id = value?["id"] as? Int
        let name = value?["name"] as? String
        let lon = value?["lon"] as? Double
        let lat = value?["lat"] as? Double
        let forecastWeather = [Weather]()
        let ref = snapshot.ref
       
        return City(name: name, id: id, lon: lon, lat: lat, currentWeather: currentWeather, forecastWeather: forecastWeather, ref: ref)
    }
}
