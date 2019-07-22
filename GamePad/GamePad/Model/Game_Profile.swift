//
//  Game_Profile.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 31/05/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation
import SwiftyJSON


class Game_Profile{
    var username: String
    var score: Int
    var gameId: Int
    var profileId: Int
    
    init(username: String, score: Int, gameId: Int, profileId: Int){
        self.username = username
        self.score = score
        self.gameId = gameId
        self.profileId = profileId
    }
    
    convenience init(jsonGameProfile: JSON){
        self.init(username: jsonGameProfile["username"].stringValue,
                  score: jsonGameProfile["score"].intValue,
                  gameId: jsonGameProfile["gameId"].intValue,
                  profileId: jsonGameProfile["profileId"].intValue)
    }
    
    static func buildAll(from jsonGameProfiles: [JSON]) -> [Game_Profile]{
        var game_profiles: [Game_Profile] = []
        let count = jsonGameProfiles.count
        for i in 0 ..< count {
            game_profiles.append(Game_Profile(jsonGameProfile: JSON(jsonGameProfiles[i])))
        }
        return game_profiles
    }
}
