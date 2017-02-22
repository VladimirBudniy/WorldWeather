//
//  Parser.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/16/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Firebase

func parse(json: Any, for user: User?) {
    let stringConst = StringConst()
    let json = json as? [String: Any]
    let coord = json?[stringConst.coord] as? [String: Any]
    let weather = json?[stringConst.weather] as? [[String: Any]]
    let icon = weather?.first?[stringConst.icon] as? String
    
    let main = json?[stringConst.main] as? [String: Any]
    let wind = json?[stringConst.wind] as? [String: Any]
    let id = json?[stringConst.id] as? Int
    let name = json?[stringConst.name] as? String
    let ref = FIRDatabase.database().reference()
    let date = Date.currentStringDate()
    
    let currentWeather = [stringConst.temp: main?[stringConst.temp],
                          stringConst.temp_min: main?[stringConst.temp_min],
                          stringConst.temp_max: main?[stringConst.temp_max],
                          stringConst.pressure: main?[stringConst.pressure],
                          stringConst.windSpeed: wind?[stringConst.speed],
                          stringConst.icon: icon,
                          stringConst.data: date]
    
    let city = [stringConst.name: name!,
                stringConst.id: id!,
                stringConst.lon: coord?[stringConst.lon],
                stringConst.lat: coord?[stringConst.lat],
                stringConst.currentWeather: currentWeather]
    
    ref.child((user?.email)!).child(stringConst.cities).child(name!).setValue(city)
}

func parse(json: [[String: Any]] , for city: City?) {
    var weathers = [[String: Any]]()
    let ref = city?.ref
    let stringConst = StringConst()
    for item in json {
        let weather = item[stringConst.weather] as? [[String: Any]]
        let icon = weather?.first?[stringConst.icon] as? String
        let main = item[stringConst.main] as? [String: Any]
        let wind = item[stringConst.wind] as? [String: Any]
        let date = item[stringConst.dtTxt] as? String

        let currentWeather = [stringConst.temp: main?[stringConst.temp],
                              stringConst.temp_min: main?[stringConst.temp_min],
                              stringConst.temp_max: main?[stringConst.temp_max],
                              stringConst.pressure: main?[stringConst.pressure],
                              stringConst.windSpeed: wind?[stringConst.speed],
                              stringConst.icon: icon,
                              stringConst.data: date]
        weathers.append(currentWeather)
    }
    
    ref?.child(stringConst.forecastWeather).setValue(weathers)
}

