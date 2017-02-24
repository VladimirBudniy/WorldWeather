//
//  CityCell.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/16/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import QuartzCore

class CityCell: UITableViewCell {
    
    @IBOutlet var cityName: UILabel?
    @IBOutlet var tempImageView: UIImageView?
    @IBOutlet var weatherImageView: UIImageView?
    @IBOutlet var tempLabel: UILabel?
    @IBOutlet var windImage: UIImageView?
    @IBOutlet var windSpeedLabel: UILabel?
    
    func fillWith(city: City?) {
        let cellsConst = CellsStringConst()
        
        self.cityName?.text = city?.name
        let weather = city?.currentWeather
        
        if (weather?.temp)! < 10.0 {
            self.tempImageView?.image = UIImage(named: cellsConst.coldImage)
        } else {
            self.tempImageView?.image = UIImage(named: cellsConst.hotImage)
        }
        
        if (weather?.windSpeed)! < 10.0 {
            self.windImage?.image = UIImage(named: cellsConst.lightWindImage)
        } else {
            self.windImage?.image = UIImage(named: cellsConst.strongWindImage)
        }
        
        self.weatherImageView?.image = UIImage(named: (weather?.icon)!)
        self.tempLabel?.text = (weather?.temp?.description)! + cellsConst.celsius
        self.windSpeedLabel?.text = (weather?.windSpeed?.description)! + cellsConst.windSpeed
    }
}
