//
//  CurrentWeatherCell.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/21/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {

    @IBOutlet var cityNameLabel: UILabel?
    @IBOutlet var tempImageView: UIImageView?
    @IBOutlet var mainImageView: UIImageView?
    @IBOutlet var windImageView: UIImageView?
    @IBOutlet var tempLabel: UILabel?
    @IBOutlet var windLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var pressureLabel: UILabel?
    @IBOutlet var tempMinLabel: UILabel?
    @IBOutlet var tempMaxLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillWith(weather: Weather?, city: City?) {
        self.cityNameLabel?.text = city?.name
        self.mainImageView?.image = UIImage(named: (weather?.icon)!)
        
        if (weather?.windSpeed)! < 10.0 {
            self.windImageView?.image = UIImage(named: "905")
        } else {
            self.windImageView?.image = UIImage(named: "906")
        }
        
        if (weather?.temp)! < 10.0 {
            self.tempImageView?.image = UIImage(named: "903")
        } else {
            self.tempImageView?.image = UIImage(named: "904")
        }
        
        self.tempLabel?.text = (weather?.temp?.description)! + " \u{00B0}C"
        self.tempMinLabel?.text = (weather?.temp_min?.description)! + " \u{00B0}C"
        self.tempMaxLabel?.text = (weather?.temp_max?.description)! + " \u{00B0}C"
        self.windLabel?.text = (weather?.windSpeed?.description)! + " m/s"
        self.dateLabel?.text = Date.currentStringDate()
        self.pressureLabel?.text = (weather?.pressure?.description)! + " mb"
    }
}
