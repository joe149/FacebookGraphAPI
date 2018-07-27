//
//  ViewController.swift
//  FacebookGraphAPI
//
//  Created by Joe Elwell on 7/17/18.
//  Copyright © 2018 Joe Elwell. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore


class ViewController: UIViewController {

    override func viewDidLoad() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginButtonTouched(_ sender: Any) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile,.userFriends,.userBirthday,.userPhotos], viewController: self) {
            
            (loginResult) in
            
            switch loginResult {
            case .failed(let error):
                self.loginError(error.localizedDescription)
            case .cancelled:
                print("User cancelled login.")
            case .success(_,_, let accessToken):
                if let userID = accessToken.userId {
                    self.performSegue(withIdentifier: "pushGetUserInfo", sender: userID)
                }
            }
        }
    }
    
    func loginError(_ message:String) {
        
        let alert = UIAlertController(title: "Login Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userID = sender as? String,
            let getUserInfoViewController = segue.destination as? GetUserInfoViewController {
            getUserInfoViewController.userID = userID 
        }
    }
}

