//
//  NetworkForRefresh.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/21/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

func refreshWeather(in cities: [String]?, for user: User, errorBlock: @escaping error) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    if let cities = cities {
        let cities = cities.joined(separator: ",").addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let url = URL(string: String.localizedStringWithFormat(Path().refreshPath, cities))
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
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String: Any]
                    if let JSON = json?["list"] as? [[String: Any]] {
                        for item in JSON {
                            parse(json: item, for: user)
                        }
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
