//
//  LoginViewController.swift
//  GamePad
//
//  Created by Gonzalo León Suárez on 24/06/18.
//  Copyright © 2018 QWERTY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextBox: UITextField!
    
    @IBOutlet weak var passwordTextBox: UITextField!
    
    var user: User = User()
    let profile = Profile()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        authenticateUser()
        run(after: 2){
            if self.profile.userId != "" {
                self.executeSegue()
            }
        }
    }
    
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline){
            completion()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMain" {
            HomeViewController.GlobalVariable.profile = self.profile
        }
        return
    }
    
    func executeSegue(){

            self.performSegue(withIdentifier: "showMain", sender: self)
    }

    
    func authenticateUser(){
        let repository = GamePadRepository()
        let parameters = ["email": emailTextBox.text!, "password" : passwordTextBox.text!]
        Alamofire.request(GamepadApi.userAuthenticationUrl, method: .post, parameters: parameters).validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.user = User.buildAll(from: json["data"])
                print(self.user.idUser)
                print(self.user.emailUser)
                self.user.accessToken = (response.response?.allHeaderFields["access-token"]) as! String
                self.user.client = (response.response?.allHeaderFields["client"]) as! String
                self.user.emailUser = (response.response?.allHeaderFields["uid"]) as! String
                
                repository.accessTokenAuthentication = self.user.accessToken
                repository.clientAuthentication = self.user.client
                repository.emailAuthentication = self.user.emailUser
                self.getProfileUser(user: self.user)
            case .failure(let error):
                print("Response Error: \(error.localizedDescription)")
                
            }
        })
    }
    
    func getProfileUser(user: User){
        let finalUrl = GamepadApi.profilesUrl + user.idUser
        Alamofire.request(finalUrl).validate().responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                self.profile.user = self.user
                self.profile.role = json["role"].stringValue
                self.profile.userId = json["id"].stringValue
            case .failure(let error):
                print("Response error: \(error.localizedDescription)")
            }
        })
        
    }

}
