//
//  Game.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 31/05/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation
import SwiftyJSON
class Game{
    var id: String
    var url_image: String
    var name: String
    var description: String
    
    
    init(id: String, url_image: String, name: String, description: String){
        self.id = id
        self.url_image = url_image
        self.name = name
        self.description = description
    }

    convenience init(jsonGame: JSON){
        self.init(id: jsonGame["id"].stringValue,
                  url_image: jsonGame["url_image"].stringValue,
                  name: jsonGame["name"].stringValue,
                  description: jsonGame["description"].stringValue)
    }
    
    static func buildAll(from jsonGames: [JSON]) -> [Game]{
        var games: [Game] = []
        let count = jsonGames.count
        for i in 0 ..< count {
            games.append(Game(jsonGame: JSON(jsonGames[i])))
        }
        return games
    }
    
}
