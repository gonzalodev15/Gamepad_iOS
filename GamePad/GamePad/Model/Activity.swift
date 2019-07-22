//
//  Activity.swift
//  GamePad
//
//  Created by Alumnos on 5/31/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation
import SwiftyJSON

class Activity{
    var id: String
    var title: String
    var short_message: String
    var description: String
    var url_image: String
    var location: String
    var city: String
    var activity_date: String
    var begin_hour: String
    var is_free: Bool
    var inscription_cost: Float
    var state: String
    var profile_id: Int
    var type_activity: String
    var monetary_unit: String
    var tournament: Tournament?
    var organiser : Profile?
    
    
    init(id: String, title: String, short_message: String,
        description:String, url_image: String, location: String,
        city: String, activity_date: String, begin_hour: String, is_free: Bool,
        inscription_cost: Float, state: String, profile_id: Int, type_activity: String, monetary_unit: String,
        tournament: Tournament?, organiser: Profile?){
        self.id = id
        self.title = title
        self.short_message = short_message
        self.description = description
        self.url_image = url_image
        self.location = location
        self.city = city
        self.activity_date = activity_date
        self.begin_hour = begin_hour
        self.is_free = is_free
        self.inscription_cost = inscription_cost
        self.state = state
        self.profile_id = profile_id
        self.type_activity = type_activity
        self.monetary_unit = monetary_unit
        self.tournament = tournament
        self.organiser = organiser
    }
    
    convenience init(activity: Activity){
        self.init(id: activity.id, title: activity.title, short_message: activity.short_message,
                  description: activity.description, url_image: activity.url_image, location: activity.location,
                  city: activity.city, activity_date: activity.activity_date, begin_hour: activity.begin_hour,
                  is_free: activity.is_free, inscription_cost: activity.inscription_cost, state: activity.state,
                  profile_id: activity.profile_id, type_activity: activity.type_activity, monetary_unit: activity.monetary_unit, tournament: activity.tournament, organiser: activity.organiser)
    }
    
    convenience init(jsonEvent: JSON){
        self.init(id: jsonEvent["id"].stringValue,
                  title: jsonEvent["title"].stringValue,
                  short_message: jsonEvent["shortMessage"].stringValue,
                  description: jsonEvent["description"].stringValue,
                  url_image: jsonEvent["urlImage"].stringValue,
                  location: jsonEvent["location"].stringValue,
                  city: jsonEvent["city"].stringValue,
                  activity_date: jsonEvent["activityDate"].stringValue,
                  begin_hour: jsonEvent["beginHour"].stringValue,
                  is_free: jsonEvent["isFree"].boolValue,
                  inscription_cost: jsonEvent["inscriptionCost"].floatValue,
                  state: jsonEvent["state"].stringValue,
                  profile_id: jsonEvent["profileId"].intValue,
                  type_activity: jsonEvent["typeActivity"].stringValue,
                  monetary_unit: jsonEvent["monetaryUnit"].stringValue,
                  tournament: nil, organiser: nil)
    }
    
    convenience init(jsonTournament: JSON){
        self.init(id: jsonTournament["id"].stringValue,
                  title: jsonTournament["title"].stringValue,
                  short_message: jsonTournament["shortMessage"].stringValue,
                  description: jsonTournament["description"].stringValue,
                  url_image: jsonTournament["urlImage"].stringValue,
                  location: jsonTournament["location"].stringValue,
                  city: "", //jsonTournament["city"].stringValue,
                  activity_date: jsonTournament["activityDate"].stringValue,
                  begin_hour: jsonTournament["beginHour"].stringValue,
                  is_free: jsonTournament["isFree"].boolValue,
                  inscription_cost: jsonTournament["inscriptionCost"].floatValue,
                  state: jsonTournament["state"].stringValue,
                  profile_id: jsonTournament["profileId"].intValue,
                  type_activity: jsonTournament["typeActivity"].stringValue,
                  monetary_unit: "", //jsonTournament["monetaryUnit"].stringValue,
                  tournament: Tournament(jsonTournament: JSON(jsonTournament["tournaments"].object)),
                  organiser: nil)
    }
    
    static func buildAllInscriptions(jsonActivity: JSON) -> [Activity]{
        var inscriptions: [Activity] = []
        let jsonInscriptions = jsonActivity.arrayValue
        let count = jsonInscriptions.count
        for i in 0 ..< count {
            let jsonActivities = JSON(jsonInscriptions[i])
            let inscription = Activity.init(id: "", title: jsonActivities["title"].stringValue, short_message: "", description: "", url_image: jsonActivities["urlmage"].stringValue, location: "", city: "", activity_date: "", begin_hour: "", is_free: true, inscription_cost: 0.00, state: jsonActivities["state"].stringValue, profile_id: 0, type_activity: "", monetary_unit: "", tournament: nil, organiser: Profile.init(jsonProfile: jsonActivities["organiser"]))
            inscriptions.append(inscription)
        }
        return inscriptions
    }
    

    
    static func buildAll(fromEvents jsonEvents: [JSON]) -> [Activity]{
        var activities: [Activity] = []
        let count = jsonEvents.count
        for i in 0 ..< count {
            activities.append(Activity(jsonEvent: JSON(jsonEvents[i])))
        }
        return activities
    }
    
    static func buildAll(fromTournaments jsonTournaments: [JSON]) -> [Activity]{
        var activities: [Activity] = []
        let count = jsonTournaments.count
        for i in 0 ..< count {
            activities.append(Activity(jsonTournament: JSON(jsonTournaments[i])))
        }
        return activities
    }
    
}
