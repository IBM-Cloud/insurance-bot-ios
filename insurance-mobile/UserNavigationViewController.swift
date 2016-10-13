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

class UserNavigationViewController: UIViewController {
    
    
    @IBOutlet var userImageContainerView: UIView!
    @IBOutlet var avatarImage: UIImageView!
    
    @IBOutlet var askQuestionButton: UIButton!
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func showChatView(sender: UIButton) {
        
        self.performSegue(withIdentifier: "chatsegue", sender: nil)
    }
    
    @IBAction func enableQuestionButton(_ sender: AnyObject) {
        askQuestionButton.alpha = 0
        askQuestionButton.isEnabled = true
        askQuestionButton.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.askQuestionButton.alpha = 1
        }
    }
    
    override func viewWillAppear(_  animated: Bool) {
        super.viewWillAppear(animated)
        if let nc = self.navigationController {
            nc.setNavigationBarHidden(false, animated: true)
            self.navigationItem.setHidesBackButton(true, animated: false)
            //userImageContainerView.layer.borderColor = UIColor.init(colorLiteralRed: 0.82, green: 0.82, blue: 0.82, alpha: 1).cgColor
        }
    }
}



