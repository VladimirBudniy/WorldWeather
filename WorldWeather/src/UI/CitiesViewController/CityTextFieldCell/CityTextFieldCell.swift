//
//  CityTextFieldCell.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/16/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class CityTextFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet var cityTextField: UITextField?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.cityTextField?.delegate = self
    }
    
    // MARK: - UITextFieldDelegate Protocol Reference
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case let textField where textField == self.cityTextField:
            return (self.cityTextField?.endEditing(true))!
            
        default:
            return true
        }
    }
}
