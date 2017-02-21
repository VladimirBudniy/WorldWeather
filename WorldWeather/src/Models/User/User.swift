//
//  User.swift
//  WorldWeather
//
//  Created by Vladimir Budniy on 2/15/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import Foundation
import Firebase

struct User {
    var email: String?
    var key: String?
    var cities: [City]?
    var ref: FIRDatabaseReference
}

extension User {
    static func createFrom(snapshot: FIRDataSnapshot) -> User {
        let stringConst = StringConst()
        let value = snapshot.value as? NSDictionary
        let email = value?[stringConst.login] as? String
        let key = value?[stringConst.password] as? String
        let cities = [City]()
        let ref = snapshot.ref
        
        return User(email: email, key: key, cities: cities, ref: ref)
    }
}
