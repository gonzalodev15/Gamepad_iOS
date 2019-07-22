//
//  FavoritesViewController.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 10/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class myTournamentCell: UICollectionViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var myTournamentNameLabel: UILabel!
    
    func updateViews(from myTournament: Activity){
         myTournamentNameLabel.text = myTournament.title
        if let url = URL(string: myTournament.url_image){
            pictureImageView.af_setImage(withURL: url)
        }
    }
}

class MyTournamentsViewController: UICollectionViewController {

    var myTournaments : [Activity] = []
    let homeVC: HomeViewController = HomeViewController()
    var profile : Profile = HomeViewController.GlobalVariable.profile
    var currentTournament: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(HomeViewController.GlobalVariable.profile.userId)
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
        return myTournaments.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! myTournamentCell
    
        // Configure the cell
        cell.updateViews(from: myTournaments[indexPath.row])
        return cell
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
        let finalUrl = GamepadApi.profilesUrl + HomeViewController.GlobalVariable.profile.userId + "/inscriptions"
        Alamofire.request(finalUrl).validate().responseJSON(completionHandler: {
            response in
            switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    self.myTournaments = Activity.buildAllInscriptions(jsonActivity: json["inscriptions"])
                self.collectionView!.reloadData()
                case .failure(let error):
                    print("Response Error: \(error.localizedDescription)")
            }
        })
    }

}
