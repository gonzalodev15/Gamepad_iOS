//
//  TournamentsViewController.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 8/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

private let reuseIdentifier = "Cell"

class EventCell: UICollectionViewCell{
    @IBOutlet var pictureImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    func updateViews(from activity: Activity){
        nameLabel.text = activity.title
        if let url = URL(string: activity.url_image){
            pictureImageView.af_setImage(withURL: url)
        }
 
    }
}
    


class EventsViewController: UICollectionViewController {
    
    var events: [Activity] = []
    var currentEvent: Int = 0
    
    
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
        // Configure the cell
        return events.count
    }




    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventCell
 
        // Configure the cell
        cell.updateViews(from: events[indexPath.row])
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
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentEvent = indexPath.row
        self.performSegue(withIdentifier: "showEventDetail", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventDetail" {
            let eventController = (segue.destination as! UINavigationController).viewControllers.first as! EventViewController
            eventController.event = events[currentEvent]
        }
        return
    }

    
    
    /*override func viewDidAppear(_ animated: Bool) {
        if let collectionView = collectionView {
            if collectionView.numberOfItems(inSection: 0) > 0 {
                collectionView.reloadItems(at: [IndexPath(
                    item: self.currentEvent, section: 0)])
            }
        }
        updateData()
    }
    */
    
    func updateData(){
        let parameters = ["state" : "active"]
            Alamofire.request(GamepadApi.activeEventsUrl, parameters: parameters).validate()
            .responseJSON(completionHandler: { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.events = Activity.buildAll(fromEvents: json["activities"].arrayValue)
                    self.collectionView!.reloadData()
                case .failure(let error):
                    print("Response Error: \(error.localizedDescription)")
                }
        })
    
    }
}

