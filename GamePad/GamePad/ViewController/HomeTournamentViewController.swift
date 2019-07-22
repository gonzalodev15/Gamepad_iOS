//
//  HomeTournamentDetailViewController.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 22/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeTournamentViewController: UIViewController {
    
    var homeTournament: Activity?{
        didSet{
            print("Selected \(homeTournament!.id)")
            print("Selected \(homeTournament!.tournament!.gameId)")
        }
    }
    var profile: Profile?

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityDateLabel: UILabel!
    @IBOutlet weak var beginHourLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let homeTournament = homeTournament{
            nameLabel.text = homeTournament.title
            descriptionLabel.text = homeTournament.description
            cityLabel.text = homeTournament.city
            locationLabel.text = homeTournament.location
            activityDateLabel.text = homeTournament.activity_date
            beginHourLabel.text = homeTournament.begin_hour
            if let url = URL(string: homeTournament.url_image){
                pictureImageView.af_setImage(withURL: url)
            }
        }
        
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func inscriptionAction(_ sender: UIButton) {
        
        let parameters = ["game_id": homeTournament!.tournament!.gameId, "activity_id": homeTournament!.id , "profile_id": profile!.userId]
        print(parameters["game_id"]!)
        print(parameters["activity_id"]!)
        print(parameters["profile_id"]!)
            Alamofire.request(GamepadApi.inscriptInTournament, method: .post, parameters: parameters).validate()
                .responseJSON(completionHandler: {response in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                print("Response error: \(error.localizedDescription)")
            }
        })
    }
    
    
}
