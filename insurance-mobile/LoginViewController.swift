//
//  ViewController.swift
//  jobcentre
//
//  Created by Anton McConville on 2016-09-15.
//  Copyright © 2016 Anton McConville. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var username : UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBAction func login(sender: UIButton) {
        // do something
        
        print(username.text);
        print(password.text);
        
        DataManager.sharedInstance.login(email: username.text!, password: password.text!) { (result) in
            
            //assume logged in for now
            print("logged in")
            self.performSegue(withIdentifier: "loginsegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(_  animated: Bool) {
        super.viewWillAppear(animated)
        if let nc = self.navigationController {
            nc.setNavigationBarHidden(true, animated: false)
            //nc.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 40, green: 61, blue: 86, alpha: 100)
        }
    }
}

