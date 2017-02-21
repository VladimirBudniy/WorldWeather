//
//  CitiesViewController.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/16/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import Firebase

class CitiesViewController: UIViewController, ViewControllerRootView, UITableViewDataSource, UITableViewDelegate, AlertViewController {
    
    // MARK: - Accessors

    typealias RootViewType = CitiesView
    var ref = FIRDatabase.database().reference()
    var logged: Bool
    let user: User
    var cities = [City]()
    let identifier = String(describing: CityCell.self)
    
    var tableView: UITableView? {
        return self.rootView.tableView
    }
    
    // MARK: - Initializations and Deallocations
    
    init(user: FIRUser?, logged: Bool) {
        let login = user?.email?.replacingOccurrences(of: ".", with: "_")
        let user = User(email: login, key: user?.uid, cities: [City](), ref: self.ref)
        self.user = user
        self.logged = logged
        if let citeis = user.cities {
            self.cities = citeis
        }
        
        super.init(nibName: String(describing: CitiesViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Use init(order:)")
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveToFirebase()
        self.settingNavigationBar()
        self.addRefreshControl()
        self.registerCellWith(identifier: String(describing: CityCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.loadFromFirebase()
    }
    
    // MARK: - NavigationBar Action
    
    @objc private func addCity() {
        if self.cities.count <= 15 {
            let text = self.rootView.cityTextField?.text
            if text != "" {
                load(city: text, for: self.user, errorBlock: loadError)
                self.rootView.cityTextField?.text = ""
            }
        }else {
            self.showAlertController(message: AlertControllerConst().citiesQty)
        }
    }
    
    @objc private func popViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func loadError(error: Error) {
        self.tableView?.refreshControl?.endRefreshing()
        let message = error.localizedDescription
        self.showAlertController(message: message)
    }
    
    private func showAlertController(message: String) {
        self.present(self.alertViewController(message: message), animated: true, completion: nil)
    }
    
    private func registerCellWith(identifier: String) {
        self.tableView?.register(UINib(nibName: identifier, bundle: nil),
                                 forCellReuseIdentifier: identifier)
    }
    
    private func loadCell(for tableView: UITableView, with identifier: String) -> UITableViewCell? {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        
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
        let rightImage = UIImage(named: names.rightButton)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(addCity))
        
        let leftImage = UIImage(named: names.leftButton)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(popViewController))
    }
    
    // MARK: - UIRefreshControl
    
    private func addRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshLoad), for: .valueChanged)
        self.tableView?.refreshControl = refresh
    }
    
    @objc private func refreshLoad() {
        self.tableView?.refreshControl?.beginRefreshing()
        var citiesID = [String]()
        for city in self.cities {
            if let id = city.id?.description {
                citiesID.append(id)
            }
        }
        
        load(cities: citiesID, for: self.user, errorBlock: loadError)
    }
    
    // MARK: - Firebase
    
    private func saveToFirebase() {
        let login = self.user.email
        let password = self.user.key
        let cities = self.user.cities
        let stringConst = StringConst()
        let user = [stringConst.login: login!,
                    stringConst.password: password!,
                    stringConst.cities: cities!] as [String : Any]
        
        if self.logged == false {
            let ref = self.ref.child(login!)
            let userName = ref.description().components(separatedBy: "/").last?.replacingOccurrences(of: "%40", with: "@")
            if userName != login?.description {
                ref.setValue(user, withCompletionBlock: { success in
                    if let error = success.0 {
                        print(" CitiesViewController - Error - %@", error)
                    }
                })
            }
        }
    }
    
    private func loadFromFirebase() {
        self.ref.child(self.user.email!).child(StringConst().cities).observe(FIRDataEventType.value, with: { (snapshot) in
            var array = [City]()
            for child in snapshot.children {
                array.append(City.createFrom(snapshot: child as! FIRDataSnapshot))
            }
            
            self.cities = array
            self.tableView?.reloadData()
            self.tableView?.refreshControl?.endRefreshing()
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
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.loadCell(for: tableView, with: String(describing: CityCell.self)) as! CityCell
        cell.fillWith(city: self.cities[indexPath.row])
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let controller = ForecastWeatherViewController()
        controller.city = self.cities[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.cities[indexPath.row].ref.removeValue()
            cities.remove(at: indexPath.row)
            self.tableView?.reloadData()
        }
    }
    
}
