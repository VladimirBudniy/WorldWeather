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
        let cellsConst = CellsStringConst()
        
        self.cityNameLabel?.text = city?.name
        self.mainImageView?.image = UIImage(named: (weather?.icon)!)
        
        if (weather?.windSpeed)! < 10.0 {
            self.windImageView?.image = UIImage(named: cellsConst.lightWindImage)
        } else {
            self.windImageView?.image = UIImage(named: cellsConst.strongWindImage)
        }
        
        if (weather?.temp)! < 10.0 {
            self.tempImageView?.image = UIImage(named: cellsConst.coldImage)
        } else {
            self.tempImageView?.image = UIImage(named: cellsConst.hotImage)
        }
        
        self.tempLabel?.text = (weather?.temp?.description)! + cellsConst.celsius
        self.tempMinLabel?.text = (weather?.temp_min?.description)! + cellsConst.celsius
        self.tempMaxLabel?.text = (weather?.temp_max?.description)! + cellsConst.celsius
        self.windLabel?.text = (weather?.windSpeed?.description)! + cellsConst.windSpeed
        self.dateLabel?.text = Date.currentStringDate()
        self.pressureLabel?.text = (weather?.pressure?.description)! + cellsConst.pressure
    }
}
