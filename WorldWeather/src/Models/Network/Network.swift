//
//  Network.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/15/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

typealias error = (Error) -> ()

func loadWeather(for city: String?, for user: User, errorBlock: @escaping error) {
    if let city = city {
        let city = city.urlEscaped
        let url = URL(string: String.localizedStringWithFormat(Path().loadCityPath, city))
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
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String: Any]
                    let name = json?[StringConst().name] as? String
                    let cityName = city.replacingOccurrences(of: "%20", with: " ")
                    if cityName != name {
                        let error = NSError(domain: AlertControllerConst().cityNotFound, code: 502)
                        DispatchQueue.main.async {
                            errorBlock(error)
                        }
                    } else {
                        parse(json: json, for: user)
                    }
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
