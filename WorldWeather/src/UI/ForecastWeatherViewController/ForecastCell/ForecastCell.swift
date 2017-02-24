//
//  ForecastCell.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/21/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    @IBOutlet var separateView: UIView?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var timeLabel: UILabel?
    @IBOutlet var tempImageView: UIImageView?
    @IBOutlet var tempLabel: UILabel?
    @IBOutlet var windImageView: UIImageView?
    @IBOutlet var windLabel: UILabel?
    @IBOutlet var mainImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillWith(weather: Weather?) {
        let cellsConst = CellsStringConst()
        let dataForDate = weather?.date?.components(separatedBy: " ")
        self.dateLabel?.text = Date.convertDateString(dateString: dataForDate?[0])
        
        let time = Date.convertTimeString(timeString: dataForDate?[1])
        self.timeLabel?.text = time
        
        if time == "00:00" {
            self.separateView?.alpha = 1
        } else {
            self.separateView?.alpha = 0
        }
        
        if (weather?.temp)! < 10.0 {
            self.tempImageView?.image = UIImage(named: cellsConst.coldImage)
        } else {
            self.tempImageView?.image = UIImage(named: cellsConst.hotImage)
        }
        
        if (weather?.windSpeed)! < 10.0 {
            self.windImageView?.image = UIImage(named: cellsConst.lightWindImage)
        } else {
            self.windImageView?.image = UIImage(named: cellsConst.strongWindImage)
        }
        
        self.tempLabel?.text = (weather?.temp?.description)! + cellsConst.celsius
        self.windLabel?.text = (weather?.windSpeed?.description)! + cellsConst.windSpeed
        self.mainImageView?.image = UIImage(named: (weather?.icon)!)
    }
}
