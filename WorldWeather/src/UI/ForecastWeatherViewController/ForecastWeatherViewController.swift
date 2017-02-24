//
//  ForecastWeatherViewController.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/14/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import Firebase

class ForecastWeatherViewController: UIViewController, ViewControllerRootView, AlertViewController, UITableViewDataSource, UITableViewDelegate {
    
    typealias RootViewType = ForecastWeatherView
    var city: City?
    var weathers = [Weather]()
    
    var tableView: UITableView? {
        return self.rootView.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.settingTableView()
        self.loadFromFirebase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        forecastWeather(for: self.city, errorBlock: loadError)
    }
    
    // MARK: - Swipe Gesture Recognizer

    @IBAction func popViewController(_ sender: UISwipeGestureRecognizer) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func registerCellWith(identifier: String) {
        self.tableView?.register(UINib(nibName: identifier, bundle: nil),
                                 forCellReuseIdentifier: identifier)
    }
    
    private func settingTableView() {
        self.registerCellWith(identifier: String(describing: CurrentWeatherCell.self))
        self.registerCellWith(identifier: String(describing: ForecastCell.self))
    }
    
    
    private func loadCell(for tableView: UITableView, with identifier: String) -> UITableViewCell? {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        
        tableView.rowHeight = (cell?.contentView.frame.size.height)!
        
        return cell
    }
    
    private func loadError(error: Error) {
        self.tableView?.refreshControl?.endRefreshing()
        let message = error.localizedDescription
        self.showAlertController(message: message)
    }
    
    private func showAlertController(message: String) {
        self.present(self.alertViewController(message: message), animated: true, completion: nil)
    }
    
    // MARK: - Firebase
    
    private func loadFromFirebase() {
        self.city?.ref.child(StringConst().forecastWeather).observe(FIRDataEventType.value, with: { (snapshot) in
            var array = [Weather]()
            for child in snapshot.children {
                array.append(Weather.createFrom(snapshot: child as! FIRDataSnapshot))
            }
            
            self.weathers = array
            self.tableView?.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.loadCell(for: tableView, with: String(describing: CurrentWeatherCell.self)) as? CurrentWeatherCell
            cell?.fillWith(weather: self.weathers[indexPath.row], city: self.city)
            
            return cell!
        } else {
            let cell = self.loadCell(for: tableView, with: String(describing: ForecastCell.self)) as? ForecastCell
            cell?.fillWith(weather: self.weathers[indexPath.row])
            
            return cell!
        }
    }
}
