//
//  ForecastWeatherViewController.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/14/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import Firebase

class ForecastWeatherViewController: UIViewController, ViewControllerRootView {
    
    typealias RootViewType = ForecastWeatherView
    var city: City?
    var weathers = [Weather]()
    
    var tableView: UITableView? {
        return self.rootView.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingNavigationBar()
        self.addRefreshControl()
        settingTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // MARK: - NavigationBar Action
    
    @objc private func popViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func registerCellWith(identifier: String) {
        self.tableView?.register(UINib(nibName: identifier, bundle: nil),
                                 forCellReuseIdentifier: identifier)
    }
    
    
    private func settingTableView() {
        self.tableView?.contentInset.top = 60
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
    
    private func settingNavigationBar() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isHidden = false
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.isTranslucent = true
        self.addBarButtons()
    }
    
    private func addBarButtons() {
        let names = NavigationBarButtonName()
        let leftImage = UIImage(named: names.leftButton)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(popViewController))
    }
    
    // MARK: - Firebase
    
    private func saveToFirebase() {
        let ref = self.city?.ref.child("forecastWeather")
        ref?.setValue(self.weathers, withCompletionBlock: { success in
            if let error = success.0 {
                print(" CitiesViewController - Error - %@", error)
            }
        })
    } /////////////////////////////////////////////////////////////////////////////////////

    private func loadFromFirebase() {
        self.city?.ref.child("forecastWeather").observe(FIRDataEventType.value, with: { (snapshot) in
            var array = [Weather]()
            for child in snapshot.children {
                array.append(Weather.createFrom(snapshot: child as! FIRDataSnapshot))
            }
            
            self.weathers = array
            self.tableView?.reloadData()
            self.tableView?.refreshControl?.endRefreshing()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - UIRefreshControl
    
    private func addRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshLoad), for: .valueChanged)
        // self.tableView?.refreshControl = refresh
    }
    
    @objc private func refreshLoad() {
        //        self.tableView?.refreshControl?.beginRefreshing()
        //        var citiesID = [String]()
        //        for city in self.cities {
        //            if let id = city.id?.description {
        //                citiesID.append(id)
        //            }
        //        }
        //
        //        load(cities: citiesID, for: self.user, errorBlock: loadError)
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
