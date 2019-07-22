//
//  Profile.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 31/05/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation
import SwiftyJSON

class Profile{
    var user: User
    var firstName: String
    var lastName: String
    var role: String
    var country: String
    var phone: String
    var userId: String

    
    init(user: User, firstName: String, lastName: String,
         role: String, country: String, phone: String,
         userId: String){
        self.user = user
        self.firstName = firstName
        self.lastName = lastName
        self.role = role
        self.country = country
        self.phone = phone
        self.userId = userId

    }
    
    convenience init(){
        self.init(user: User(),
                  firstName: "",
                  lastName: "",
                  role: "",
                  country: "",
                  phone: "",
                  userId: "")

    }
    
    convenience init(jsonProfile: JSON){
        self.init(user: User(jsonUser: JSON(jsonProfile["user"])),
                  firstName: jsonProfile["firstName"].stringValue,
                  lastName: jsonProfile["lastName"].stringValue,
                  role: jsonProfile["role"].stringValue,
                  country: jsonProfile["country"].stringValue,
                  phone: jsonProfile["phone"].stringValue,
                  userId: jsonProfile["userId"].stringValue)
    }
    
    static func buildAll(from jsonProfiles: [JSON]) -> [Profile]{
        var profiles: [Profile] = []
        let count = jsonProfiles.count
        for i in 0 ..< count {
            profiles.append(Profile(jsonProfile: JSON(jsonProfiles[i])))
        }
        return profiles
    }
    
}
