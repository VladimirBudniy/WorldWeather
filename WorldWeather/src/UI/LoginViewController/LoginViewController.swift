//
//  LoginViewController.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/14/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, ViewControllerRootView, UITextFieldDelegate, AlertViewController {
    
    typealias RootViewType = LoginView
    var user: FIRUser?
    var ref = FIRDatabase.database().reference()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkCurrentUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.addTextFieldDelegate()
    }
    
    // MARK: - Action
    
    @IBAction func onLogOutButton(_ sender: Any) {
        let firebaseAuth = FIRAuth.auth()
        if let user = firebaseAuth?.currentUser {
            let userName = user.email?.replacingOccurrences(of: ".", with: "_")
            self.ref.child(userName!).removeValue()
            user.delete { [weak self] error in
                if error != nil {
                    if let messege = error?.localizedDescription {
                        self?.showAlertController(message: messege)
                        self?.rootView.passwordTextField?.text = ""
                    }
                    do {
                        try firebaseAuth?.signOut()
                        self?.rootView.changeOnRegistration()
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                }
            }
            
            self.rootView.changeOnRegistration()
        }
    }
    
    @IBAction func onRegistrationButton(_ sender: Any) {
        let view = self.rootView
        let email = view.emailTextField?.text
        let password = view.passwordTextField?.text
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!) { [weak self] (user, error) in
            if error != nil {
                if let messege = error?.localizedDescription {
                    self?.showAlertController(message: messege)
                    self?.rootView.passwordTextField?.text = ""
                }
            } else {
                self?.user = user
                let controller = CitiesViewController(user: user, logged: false)
                self?.navigationController?.pushViewController(controller, animated: true)
                
                view.changeOnLogged(emailPlaceholder: view.emailTextField?.text)
            }
        }
    }
    
    @IBAction func onSignInButton(_ sender: Any) {
        let controller = CitiesViewController(user: self.user, logged: true)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Private

    private func checkCurrentUser() {
        let currentUser = FIRAuth.auth()?.currentUser
        if currentUser != nil {
            self.user = currentUser
            self.rootView.changeOnLogged(emailPlaceholder: currentUser?.email)
            // add alert controller "продолжить как .... "
        }
    }
    
    private func addTextFieldDelegate() {
        let view = self.rootView
        view.emailTextField?.delegate = self
        view.passwordTextField?.delegate = self
    }
    
    private func showAlertController(message: String) {
        self.present(self.alertViewController(message: message), animated: true, completion: nil)
    }
    
    // MARK: - Validation
    
    private func isValidEmail(text: String?) -> Bool {
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", CheckEmailRange().emailRange)
        let bool = emailCheck.evaluate(with: text)
        if bool == false {
            self.showAlertController(message: AlertControllerConst().emailMessage)
        }
        
        return bool
    }
    
    private func checkWhitespace(string: String?) -> Bool {
        if string == " " {
            self.showAlertController(message: AlertControllerConst().whitespaceMessage)
            return false
        }
        
        return true
    }
    
    // MARK: - UITextFieldDelegate Protocol Reference
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case let textField where textField == self.rootView.emailTextField:
            let bool = self.isValidEmail(text: textField.text)
            if bool == false {
                textField.text = ""
            }
            
            self.rootView.passwordTextField?.becomeFirstResponder()
            
            return bool
            
        case let textField where textField == self.rootView.passwordTextField:
            let bool = self.rootView.passwordTextField?.endEditing(true)
            self.rootView.setupRegistrationButton()
            
            return bool!
            
        default:
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case let textField where textField == self.rootView.emailTextField:
            return true
            
        case let textField where textField == self.rootView.passwordTextField:
            return self.checkWhitespace(string: string)
            
        default:
            return true
        }
    }
}
