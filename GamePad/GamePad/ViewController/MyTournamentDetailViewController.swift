//
//  MyTournamentDetailViewController.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 24/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import UIKit

class MyTournamentDetailViewController: UIViewController {

    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityDateLabel: UILabel!
    @IBOutlet weak var beginHourLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
}
