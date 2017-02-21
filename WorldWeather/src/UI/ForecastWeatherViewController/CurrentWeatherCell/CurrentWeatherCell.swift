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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillWith(weather: Weather?) {
        
    }
}
