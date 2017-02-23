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

struct Path {
    let loadCityPath = "http://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&APPID=a755c475976f0c028f179d7f425c2a6a"
    let refreshPath = "http://api.openweathermap.org/data/2.5/group?id=%@&units=metric&APPID=a755c475976f0c028f179d7f425c2a6a"
    let forecastPath = "http://api.openweathermap.org/data/2.5/forecast?id=%@&units=metric&APPID=a755c475976f0c028f179d7f425c2a6a"
}

struct AlertControllerConst {
    let emailMessage = "Please check your email"
    let whitespaceMessage = "Please remove whitespace"
    let citiesQty = "The quantity of countries can't be more than 15 pcs!"
    let cityNotFound = "Error: Not found city"
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
