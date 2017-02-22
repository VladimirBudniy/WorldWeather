//
//  Helper.Constant.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/14/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation

struct CheckEmailRange {
    let emailRange = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
}

struct NavigationBarButtonName {
    let leftButton = "BackButton"
    let rightButton = "AddCityButton"
}

struct AlertControllerConst {
    let emailMessage = "Please check your email"
    let whitespaceMessage = "Please remove whitespace"
    let citiesQty = "The quantity of countries can't be more than 15 pcs!"
}

struct TextFieldConst {
    let email = "Please enter your Email"
    let password = "Password"
    let cleanField = ""
}

struct StringConst {
    let login = "login"
    let password = "password"
    let cities = "cities"
    let coord = "coord"
    let weather = "weather"
    let icon = "icon"
    let main = "main"
    let wind = "wind"
    let id = "id"
    let name = "name"
    let temp = "temp"
    let temp_min = "temp_min"
    let temp_max = "temp_max"
    let pressure = "pressure"
    let windSpeed = "windSpeed"
    let speed = "speed"
    let data = "data"
    let lon = "lon"
    let lat = "lat"
    let dtTxt = "dt_txt"
    let currentWeather = "currentWeather"
    let forecastWeather = "forecastWeather"
}
