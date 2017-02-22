//
//  Date+Extension.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/17/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

//"MMM d, H:mm"

extension Date {
    
    static func currentStringDate() -> String? {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let dateString = dateFormatter.string(from: currentDate)
        
        return self.convertDateString(dateString: dateString)
    }
    
    static func convertDateString(dateString: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let date = dateFormatter.date(from: dateString!)
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.string(from: date!)
    }
    
    static func convertTimeString(timeString: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: timeString!)
        dateFormatter.dateFormat = "HH:mm"
        
        return dateFormatter.string(from: date!)
    }
    
    
}
