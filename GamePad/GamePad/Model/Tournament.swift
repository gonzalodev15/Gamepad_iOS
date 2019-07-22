//
//  Tournament.swift
//  GamePad
//
//  Created by Alumnos on 5/31/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tournament{
    var isOnline: Bool
    var modalityMatch: String
    var quantityTeam: Int
    var prize: String
    var availableSpots: Int
    var rules: String
    var activityId: String
    var gameId: String
    var createdAt: String
    var updatedAt: String


    
    init(activity_id: String, isOnline: Bool, modalityMatch: String,
    quantityTeam: Int, prize: String, availableSpots: Int,
    rules: String, gameId: String, createdAt: String, updatedAt: String){

        self.activityId = activity_id
        self.isOnline = isOnline
        self.modalityMatch = modalityMatch
        self.quantityTeam = quantityTeam
        self.prize = prize
        self.availableSpots = availableSpots
        self.rules = rules
        self.gameId = gameId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
    }
    
    convenience init(jsonTournament: JSON){

        
        self.init(
                    activity_id: jsonTournament["activity_id"].stringValue,
                    isOnline: jsonTournament["is_online"].boolValue,
                    modalityMatch: jsonTournament["modalityMatch"].stringValue,
                    quantityTeam: jsonTournament["quantityTeam"].intValue,
                    prize: jsonTournament["prize"].stringValue,
                    availableSpots: jsonTournament["availableSpots"].intValue,
                    rules: jsonTournament["rules"].stringValue,
                    gameId: jsonTournament["gameId"].stringValue,
                    createdAt: jsonTournament["created_at"].stringValue,
                    updatedAt: jsonTournament["updated_at"].stringValue)
    }
    
    static func buildAll(from jsonTournaments: [JSON]) -> [Tournament]{
        var tournaments: [Tournament] = []
        let count = jsonTournaments.count
        for i in 0 ..< count {
            tournaments.append(Tournament(jsonTournament: JSON(jsonTournaments[i])))
        }
        return tournaments
    }
    
}
