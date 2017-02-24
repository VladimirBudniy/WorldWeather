//
//  LoginView.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/14/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class LoginView: UIView {
    @IBOutlet var emailTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var registerButton: UIButton?
    @IBOutlet var signInButton: UIButton?
    @IBOutlet var logOutButton: UIButton?
    
    func changeOnLogged(emailPlaceholder: String?) {
        self.emailTextField?.placeholder = emailPlaceholder
        self.emailTextField?.text = TextFieldConst().cleanField
        self.passwordTextField?.textColor = UIColor.lightGray
        self.emailTextField?.isEnabled = false
        self.passwordTextField?.isEnabled = false
        self.registerButton?.alpha = 0
        self.signInButton?.alpha = 1
        self.signInButton?.isEnabled = true
        self.logOutButton?.alpha = 1
        self.logOutButton?.isEnabled = true
    }
    
    func changeOnRegistration() {
        self.emailTextField?.placeholder = TextFieldConst().email
        self.emailTextField?.text = TextFieldConst().cleanField
        self.passwordTextField?.placeholder = TextFieldConst().password
        self.passwordTextField?.textColor = UIColor.black
        self.passwordTextField?.text = TextFieldConst().cleanField
        self.emailTextField?.isEnabled = true
        self.passwordTextField?.isEnabled = true
        self.registerButton?.alpha = 0.5
        self.signInButton?.alpha = 0
        self.signInButton?.isEnabled = false
        self.logOutButton?.alpha = 0
        self.logOutButton?.isEnabled = false
    }
    
    func setupRegistrationButton() {
        let button = self.registerButton
        button?.isEnabled = true
        button?.alpha = 1
    }
}
