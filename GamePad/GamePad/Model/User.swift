//
//  User.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 24/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftyJSON
class User{
    var idUser: String
    var emailUser: String
    var accessToken: String
    var client: String
    
    init(idUser: String, emailUser: String, accessToken: String, client:String) {
        self.idUser = idUser
        self.emailUser = emailUser
        self.accessToken = accessToken
        self.client = client
    }
    
    convenience init(){
        self.init(idUser: "", emailUser: "")
    }
    
    convenience init(idUser: String, emailUser: String){
        self.init(idUser: idUser, emailUser: emailUser, accessToken: "", client: "")
    }
    
    convenience init(idUser: String){
        self.init(idUser: idUser, emailUser: "", accessToken: "", client: "")
    }
    
    convenience init(jsonUser: JSON){
        self.init(idUser: jsonUser["id"].stringValue,
                  emailUser: jsonUser["email"].stringValue)
    }
    
    static func buildAll(from jsonUser: JSON)-> User{
        var user : User = User()
        user = User.init(jsonUser: JSON(jsonUser))
        return user
    }
}
