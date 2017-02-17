//
//  CurrentWeatherViewController.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/14/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import Firebase

class CurrentWeatherViewController: UIViewController, ViewControllerRootView {

    typealias RootViewType = CurrentWeatherView
    var user: User?
//    let userName: String?
    var ref = FIRDatabase.database().reference()

    // MARK: - Initializations and Deallocations
//
//    init(login: String) {
//        self.userName = login
//        super.init(nibName: String(describing: CurrentWeatherViewController.self), bundle: nil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("Use init(order:)")
//    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.loadDataFromFirebase()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private
    
//    private func loadDataFromFirebase() {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//        self.ref.child(self.userName!).observe(FIRDataEventType.value, with: { (snapshot) in
//            print(snapshot)
////            for child in snapshot.children {
////                array.append(Employee.createFrom(snapshot: child as! FIRDataSnapshot))
////            }
//            UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }

}
