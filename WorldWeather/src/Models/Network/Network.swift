//
//  Network.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/15/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

var path = "http://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&APPID=a755c475976f0c028f179d7f425c2a6a"
typealias error = (Error) -> ()

func loadWeather(for city: String?, for user: User, errorBlock: @escaping error) {
    if let city = city {
        let city = city.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = URL(string: String.localizedStringWithFormat(path, city))
        let request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    errorBlock(error!)
                }
            }
            if error == nil {
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments)
                    parse(json: json, for: user)
                } catch {
                    DispatchQueue.main.async {
                        errorBlock(error)
                    }
                }
            }
        })
        
        task.resume()
    }
}
