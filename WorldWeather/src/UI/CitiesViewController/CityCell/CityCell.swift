//
//  CityCell.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/16/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet var cityName: UILabel?

    @IBOutlet var tempImageView: UIImageView?
    @IBOutlet var weatherImageView: UIImageView?
    @IBOutlet var tempLabel: UILabel?
    @IBOutlet var windImage: UIImageView?
    @IBOutlet var windSpeedLabel: UILabel?
    
    func fillWith(city: City?) {
        self.cityName?.text = city?.name
        let weather = city?.currentWeather
        
        if (weather?.temp)! < 10.0 {
            self.tempImageView?.image = UIImage(named: "903")
        } else {
            self.tempImageView?.image = UIImage(named: "904")
        }
        
        self.weatherImageView?.image = UIImage(named: (weather?.icon)!)
        self.windImage?.image = UIImage(named: "905")
        self.tempLabel?.text = (weather?.temp?.description)! + " \u{00B0}C"
        self.windSpeedLabel?.text = (weather?.windSpeed?.description)! + " m/s"
    }
    
}
