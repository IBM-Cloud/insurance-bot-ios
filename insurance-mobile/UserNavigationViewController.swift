//
//  UserNavigationViewController.swift
//  insurance-mobile
//
//  Created by Andrew Trice on 10/11/16.
//  Copyright © 2016 Anton McConville. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Crypto

class UserNavigationViewController: UIViewController {
    
    
    @IBOutlet var userImageContainerView: UIView!
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var userFullNameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var askQuestionButton: UIButton!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func showChatView(sender: UIButton) {
        
        self.performSegue(withIdentifier: "chatsegue", sender: nil)
    }
    
    @IBAction func enableQuestionButton(_ sender: AnyObject) {
        /*askQuestionButton.alpha = 0
        askQuestionButton.isEnabled = true
        askQuestionButton.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.askQuestionButton.alpha = 1
        }*/
    }
    
    override func viewWillAppear(_  animated: Bool) {
        super.viewWillAppear(animated)
        if let nc = self.navigationController {
            nc.setNavigationBarHidden(false, animated: true)
            self.navigationItem.setHidesBackButton(true, animated: false)
            //userImageContainerView.layer.borderColor = UIColor.init(colorLiteralRed: 0.82, green: 0.82, blue: 0.82, alpha: 1).cgColor
        }
        
        //show name
        let dm = DataManager.sharedInstance;
        userFullNameLabel.text = "\(dm.firstName) \(dm.lastName)"
        usernameLabel.text = "ID: \(dm.userName)"
        
        //attempt to download gravatar image for email address (username)
        let hash = dm.userName.lowercased().md5
        let urlString = "https://www.gravatar.com/avatar/\(hash!)?d=404"
        let gravatarURL = URL(string:urlString)
        
        let task = URLSession.shared.dataTask(with: gravatarURL!) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if (httpResponse.statusCode == 200) {
                    DispatchQueue.main.async {
                        if let data = data {
                            self.avatarImage.image = UIImage(data:data)
                        }
                    }
                }
            }
        }
        task.resume()
    }
}



