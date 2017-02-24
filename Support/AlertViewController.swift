//
//  AlertViewController.swift
//  ShoppingList
//
//  Created by Vladimir Budniy on 11/25/16.
//  Copyright © 2016 Vladimir Budniy. All rights reserved.
//

import Foundation
import UIKit

public protocol AlertViewController {
    var alertViewController: UIAlertController { get }
}

public extension AlertViewController {
    
    var alertViewController: UIAlertController {
        let alertView = self.alertViewControllerWith(title: nil,
                                                     message: "Data is not saved!",
                                                     preferredStyle: UIAlertControllerStyle.alert,
                                                     actionTitle: "Ok",
                                                     style: UIAlertActionStyle.default,
                                                     handler: nil)
        
        return alertView
    }
    
    func alertViewControllerWith(title: String?,
                                 message: String?,
                                 preferredStyle: UIAlertControllerStyle,
                                 actionTitle: String?,
                                 style: UIAlertActionStyle,
                                 handler:((UIAlertAction) -> Void)?) -> UIAlertController
    {
        let alertView = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle)
        
        let alertAction = UIAlertAction(
            title: actionTitle,
            style: style,
            handler: handler)
        
        alertView.addAction(alertAction)
        
        return alertView
    }
    
    func alertViewController(title: String? = nil, message: String) -> UIAlertController {
        return alertViewControllerWith(title: title,
                                       message: message,
                                       preferredStyle: UIAlertControllerStyle.alert,
                                       actionTitle: "Ok",
                                       style: UIAlertActionStyle.default,
                                       handler: nil)
    }
}
