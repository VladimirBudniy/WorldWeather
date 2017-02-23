//
//  AppDelegate.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/14/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    
    // for test !!!
    // login - bob.va@gmail.com
    // password - 123456

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        let viewController = LoginViewController()
        navigationController.pushViewController(viewController, animated: true)
        window.rootViewController = navigationController
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}

