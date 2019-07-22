//
//  GamepadApi.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 31/05/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation

class GamepadApi{
    
    static let baseUrl = "https://qwerty-gamepad-cloned3-bohemio.c9users.io"
    
    public static var tournamentsUrl: String {
        return "\(baseUrl)/v1/tournaments"
    }
    public static var gamesUrl: String {
        return "\(baseUrl)/v1/games"
    }
    public static var activitiesUrl: String {
        return "\(baseUrl)/v1/activities"
    }
    public static var profilesUrl: String {
        return "\(baseUrl)/v1/profiles/"
    }

    public static var inscriptInTournament: String {
        return "\(baseUrl)/v1/inscriptions"
    }
    
    public static var activeEventsUrl: String{
        return "\(baseUrl)/v1/activities/event"
    }
    
    public static var activeTournamentsUrl: String{
        return "\(baseUrl)/v1/activities/tournament" //?state=active"
    }
    
    public static var userAuthenticationUrl: String{
        return "\(baseUrl)/auth/sign_in"
    }
    
    public static var authenticationTokenUrl: String{
        return "\(baseUrl)/v1/auth/validate_token"
    }
    
    public static var signOutUrl: String {
        return "\(baseUrl)/v1/auth/sign_out"
    }
    
    public static var registerUrl: String {
        return "\(baseUrl)/v1/auth"
    }
}
