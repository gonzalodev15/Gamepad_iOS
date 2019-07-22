//
//  HomeViewController.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 10/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

private let reuseIdentifier = "Cell"

class HomeCell: UICollectionViewCell {
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    func updateViews(from tournament: Activity){
        nameLabel.text = tournament.title
        if let url = URL(string: tournament.url_image){
            pictureImageView.af_setImage(withURL: url)
        }
    }
}

class HomeViewController: UICollectionViewController {

    var tournaments:[Activity] = []
    var currentTournament : Int = 0
    struct GlobalVariable{
        static var profile : Profile = Profile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        updateData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tournaments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
    
        // Configure the cell
        cell.updateViews(from: tournaments[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentTournament = indexPath.row
        self.performSegue(withIdentifier: "showTournamentDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTournamentDetail"{
            let homeTournamentViewController = (segue.destination as! UINavigationController).viewControllers.first as! HomeTournamentViewController
            
            homeTournamentViewController.homeTournament = tournaments[currentTournament]
            homeTournamentViewController.profile = HomeViewController.GlobalVariable.profile
        }
        return
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func updateData(){
        //let store = GamepadStore()
        //let favouriteGames = store.favouriteGameIdsAsString()
        //if favouriteGames.isEmpty{
            
        //}
        let parameters = ["state" : "active"]
        Alamofire.request(GamepadApi.activeTournamentsUrl, parameters: parameters).validate()
            .responseJSON(completionHandler: { response in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.tournaments = Activity.buildAll(fromTournaments: json["activities"].arrayValue)
                    self.collectionView!.reloadData()
                case .failure(let error):
                    print("Response error: \(error.localizedDescription)")
                }
                
            })
    }
    

}
