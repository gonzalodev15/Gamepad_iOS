//
//  GamepadRepository.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 24/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation

class GamePadRepository{
    let settings = UserDefaults.standard
    
    var emailAuthentication: String? {
        get{
            return settings.string(forKey: "savedEmail")!
        }
        set{
            if let email = newValue as String? {
                settings.set(email, forKey: "savedEmail")
                return
            }
            settings.removeObject(forKey: "savedEmail")
        }
    }
    
    var clientAuthentication: String? {
        get{
            return settings.string(forKey: "savedClient")!
        }
        set{
            if let client = newValue as String? {
                settings.set(client, forKey: "savedClient")
                return
            }
            settings.removeObject(forKey: "saved Client")
        }
    }
    
    var accessTokenAuthentication: String? {
        get{
            return settings.string(forKey: "savedAccessToken")!
        }
        set{
            if let accessToken = newValue as String? {
                settings.set(accessToken, forKey: "savedAccessToken")
                return
            }
            settings.removeObject(forKey: "savedAccessToken")
        }
    }
}
