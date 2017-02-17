//
//  Parser.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/16/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Firebase

func parse(json: Any, for user: User) {
    let json = json as? [String: Any]
    let coord = json?["coord"] as? [String: Any]
    let weather = json?["weather"] as? [[String: Any]]
    let icon = weather?.first?["icon"] as? String
    
    let main = json?["main"] as? [String: Any]
    let wind = json?["wind"] as? [String: Any]
    let id = json?["id"] as? Int
    let name = json?["name"] as? String
    let ref = FIRDatabase.database().reference()
    let date = Date.currentStringDate()
    
    let currentWeather = ["temp": main?["temp"],
                          "temp_min": main?["temp_min"],
                          "temp_max": main?["temp_max"],
                          "pressure": main?["pressure"],
                          "windSpeed": wind?["speed"],
                          "icon": icon,
                          "data": date]
    
    let city = ["name": name!,
                "id": id!,
                "lon": coord?["lon"],
                "lat": coord?["lat"],
                "currentWeather": currentWeather]
    
    ref.child(user.email!).child("cities").child(name!).setValue(city)
}
