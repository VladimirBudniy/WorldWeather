//
//  Weather.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/15/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Firebase

struct Weather {
    var temp: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var windSpeed: Double?
    var icon: String?
    var date: String?
    var ref: FIRDatabaseReference?
}

extension Weather {
    
    static func create() -> Weather {
        return Weather(temp: nil, temp_min: nil, temp_max: nil, pressure: nil,
                       windSpeed: nil, icon: nil,
                       date: nil, ref: nil)
    }
    
    
    static func createFrom(snapshot: FIRDataSnapshot) -> Weather {
        let value = snapshot.value as? NSDictionary
        let temp = value?["temp"] as? Double
        let temp_min = value?["temp_min"] as? Double
        let temp_max = value?["temp_max"] as? Double
        let pressure = value?["pressure"] as? Double
        let windSpeed = value?["windSpeed"] as? Double
        let icon = value?["icon"] as? String
        let date = value?["data"] as? String
        let ref = snapshot.ref
        
        return Weather(temp: temp, temp_min: temp_min, temp_max: temp_max, pressure: pressure,
                       windSpeed: windSpeed, icon: icon,
                       date: date, ref: ref)
    }
}
