//
//  GetUserInfoViewController.swift
//  FacebookGraphAPI
//
//  Created by Joe Elwell on 7/17/18.
//  Copyright © 2018 Joe Elwell. All rights reserved.
//

import UIKit
import FacebookCore

class GetUserInfoViewController: UIViewController {

    var userID = ""
    @IBOutlet weak var userInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func getUserInfoButtonTouched(_ sender: Any) {
        getInfo()
    }
    
    func getInfo() {
        
        let connection = GraphRequestConnection()
        let path = "/" + userID + "/friends"
        let graphRequest = GraphRequest(graphPath: path)
        
        connection.add(graphRequest) { httpResponse, result in
            switch result {
            case .success(let response):
                self.displayResponse(response.dictionaryValue)
            case .failed(let error):
                self.userInfoLabel.text = "Error from Facebook: " + error.localizedDescription
            }
        }
        connection.start()
    }
    
    func displayResponse(_ response:Dictionary<String, Any>?) {
        if let responseDictionary = response,
           let summary = responseDictionary["summary"] as? Dictionary<String,Any?>,
           let count = summary["total_count"] as? NSNumber {
            userInfoLabel.text = String(format:"You have %d friends",count.intValue)
        } else {
            userInfoLabel.text = "Bad response from Facebook"
        }
    }

}
