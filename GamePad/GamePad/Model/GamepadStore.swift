//
//  GamepadStore.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 20/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class GamepadStore{
    init(){
    }
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func save(){
        delegate.saveContext()
    }
    
    func addFavouriteGame(for game: Game){
        let favouriteGameEntity = NSEntityDescription.entity(forEntityName: "FavouriteG", in: context)
        let newFavourite = NSManagedObject(entity: favouriteGameEntity!, insertInto: context)
        
        newFavourite.setValue(game.id, forKey: "gameId")
        newFavourite.setValue(game.name, forKey: "gameName")
        newFavourite.setValue(Date(), forKey: "ccreatedAt")
        save()
    }
    
    func findFavouriteGameById(for game: Game)-> NSManagedObject?{
        let predicate = NSPredicate(format: "gameId = %@", game.id)
        return findFavouriteGameBy(predicate: predicate, for:game)
    }
    
    func findFavouriteGameByName(for game: Game) -> NSManagedObject?{
        let predicate = NSPredicate(format: "gameName = %@", game.name)
        return findFavouriteGameBy(predicate: predicate, for: game)
    }
    
    func findFavouriteGameBy(predicate: NSPredicate, for game: Game)->NSManagedObject? {
        let favouriteGameEntity = NSEntityDescription.entity(forEntityName: "FavouriteG", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: favouriteGameEntity!.name!)
        request.predicate = predicate
        
        do{
            let result = try context.fetch(request)
            if let favourite = result.first as? NSManagedObject{
                return favourite
            }
        } catch(let error){
            print("Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    func isFavouriteGame(game: Game)-> Bool {
        return findFavouriteGameById(for: game) != nil
    }
    
    func setFavourite(_ isFavouriteGame: Bool, for game: Game){
        if self.isFavouriteGame(game: game) == isFavouriteGame {
            return
        }
        if self.isFavouriteGame(game: game) {
            deleteFavourite(for: game)
        } else {
            addFavouriteGame(for: game)
        }
    }
    
    func deleteFavourite(for game: Game){
        let favourite = findFavouriteGameById(for: game)
        if let favourite = favourite {
            context.delete(favourite)
            save()
        }
    }
    
    func favourite(game: Game){
        setFavourite(true, for: game)
    }
    
    func unFavourite(game: Game){
        setFavourite(false, for: game)
    }
    
    func findAllFavourites() -> [NSManagedObject]?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteG")
        do{
            let result = try context.fetch(request)
            return result as? [NSManagedObject]
        }catch let error{
            print("Query error: \(error.localizedDescription) ")
        }
        return nil
    }
    
    func favouriteGameIdsAsString() -> String{
        let favourites = findAllFavourites()
        if let favourites = favourites{
            print("All Favourites Count: \(favourites.count)")
            return favourites.map({$0.value(forKey: "SourceId") as! String})
                .filter({ !$0.isEmpty })
                .prefix(20).joined(separator: ",")
        }
        return ""
    }
}

