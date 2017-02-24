//
//  String+Extension.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/24/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}
