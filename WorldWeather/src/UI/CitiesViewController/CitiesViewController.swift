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
        self.settingTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadFromFirebase()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.loadCell(for: tableView, with: String(describing: CityTextFieldCell.self))
            
            return cell!
        } else {
            let cell = self.loadCell(for: tableView, with: String(describing: CityCell.self)) as! CityCell
            cell.fillWith(city: self.cities[indexPath.row - 1])
            
            return cell
        }
    }
    
    // MARK: - NavigationBar Action
    
    @objc private func addCity() {
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = self.tableView?.cellForRow(at: indexPath) as? CityTextFieldCell
        if cell?.cityTextField?.text != "" {
            load(city: cell?.cityTextField?.text, for: self.user)
            cell?.cityTextField?.text = ""
        }
    }
    
    @objc private func popViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private
    
    private func loadCell(for tableView: UITableView, with identifier: String) -> UITableViewCell? {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        
        tableView.rowHeight = (cell?.contentView.frame.size.height)!
        
        return cell
    }
    
    private func registerCellWith(identifier: String) {
        self.tableView?.register(UINib(nibName: identifier, bundle: nil),
                                 forCellReuseIdentifier: identifier)
    }
    
    private func settingTableView() {
        self.tableView?.contentInset.top = 60
        self.registerCellWith(identifier: String(describing: CityTextFieldCell.self))
        self.registerCellWith(identifier: String(describing: CityCell.self))
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
        let rightImage = UIImage(named: "AddCityButton")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage,
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(addCity))
        
        let leftImage = UIImage(named: "BackButton")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftImage,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(popViewController))
    }

    private func saveToFirebase() {
        let login = self.user.email
        let password = self.user.key
        let cities = self.user.cities
        let user = ["login": login!, "password": password!, "cities": cities!] as [String : Any]
        
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
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.ref.child(self.user.email!).child("cities").observe(FIRDataEventType.value, with: { (snapshot) in
            var array = [City]()
            for child in snapshot.children {
                array.append(City.createFrom(snapshot: child as! FIRDataSnapshot))
            }
            
            self.cities = array
            self.tableView?.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //        let city = self.cities?[indexPath.row]
        //        city.ref.updateChildValues(["developer": !employee.developer!])
        //        self.tableView?.reloadData()
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
