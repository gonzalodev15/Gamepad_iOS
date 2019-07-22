//
//  TournamentViewController.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 20/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//
import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class EventViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityDateLabel: UILabel!
    @IBOutlet weak var beginHourLabel: UILabel!
    
    
    var event: Activity?{
        didSet{
            print("set: \(event!.id)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let event = event {
            
            nameLabel.text = event.title
            descriptionLabel.text = event.description
            cityLabel.text = event.city
            locationLabel.text = event.location
            activityDateLabel.text = event.activity_date
            beginHourLabel.text = event.begin_hour
            if let url = URL(string: event.url_image){
                pictureImageView.af_setImage(withURL: url)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    
}
