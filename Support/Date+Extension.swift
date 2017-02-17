//
//  Date+Extension.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/17/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

extension Date {
    
    static func currentStringDate() -> String? {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: currentDate)
    }
    
}
