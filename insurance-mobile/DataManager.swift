//
//  DataManager.swift
//  insurance-mobile
//
//  Created by Andrew Trice on 10/11/16.
//  Updates by Marek Sadowski on 10/13/16.
//  Copyright © 2016 Anton McConville. All rights reserved.
//

import Foundation

class DataManager {
    static let sharedInstance = DataManager();
    var firstName = String()
    var lastName = String()
    var userName = String()
    var loginStatus = false
    var serviceUrl = String()

    func login(email:String, password:String, completion:@escaping (Bool?)->()) -> Void {
        // perform login, then call completion callback with result 
        
        NSLog("DataManager| email: " + email)
        NSLog("DataManager| password: " + password)
        
        //parameters moved to configureMe.plist
        readConfigureMePList()
        let target = (!serviceUrl.contains("") ? serviceUrl : "http://cloudco.mybluemix.net/login")
        NSLog("DataManager| using serviceUrl: " + serviceUrl)
        
        let url:URL = URL(string: target)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let paramString = "email=" + email + "&password=" + password
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            
            (data, response, error) in
            
            guard let data = data, let _:URLResponse = response  , error == nil else {
                NSLog("DataManager| error :")
                print(response)
                
                completion(false)
                return
            }
            
            let dataString = String(data: data, encoding: String.Encoding.utf8)
            NSLog("DataManager| dataString :" + dataString!)
            let dictionary = self.convertStringToDictionary(text: dataString!)
            
            if let fname = dictionary?["fname"] {
                self.firstName = fname as! String
            }
            
            if let lname = dictionary?["lname"] {
                self.lastName = lname as! String
            }
            
            if let uname = dictionary?["username"] {
                self.userName = uname as! String
            }
            
            if let outcome = dictionary?["outcome"] {
                self.loginStatus = (outcome.isEqual("success"))
                NSLog("DataManager| login status: " + (outcome as! String))
            }
            
            completion(self.loginStatus)
        }
        task.resume()
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    //read configureMe.plist properties
    func readConfigureMePList(){
        NSLog("DataManager| reading the configureMe.plist ")
        let path = Bundle.main.path(forResource: "configureMe", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        let dictArray = plist as! [String:String]
        serviceUrl = dictArray["url"]!+dictArray["login"]!
        NSLog("DataManager| the serviceUrl: " + serviceUrl)
        
    }
    
    func postMessage(message:String, completion:(AnyObject?)->()) -> Void {
        // send chat message, then call completion with result
        
        /*
         Gonna have to look at ana.js together
         so for the date request she requires an input of YYYY-MM-DD and the amount that gets sent for the claim has to be parsed down to a number otherwise she’ll reject it
         You’re making a POST to /api/ana
         The object she accepts is params = { “text” : usermessage, “context” : context object sent after first request}
         So when the service tosses a response back you need to store the res.context to be passed with your next request.
         Finally, if when you get the context back the context.claim_step is set to “verify” that indicates a claim needs to be filed
         And you’ll have to do all the logic for calling /submitClaim
         Once a claim has been filed the following in the context object have to be reset to null: context.claim_step = '';
         context.claim_date = '';
         context.claim_provider = '';
         context.claim_amount = '';
         context.system = '';
         At the very least context.claim_step has to be reset otherwise it’ll forever trigger a file claim
         And that’s it
         
         o.k. cloudco.mybluemix.net/api/ana and parameters in the post. I need to keep context between calls. Could you confirm :slightly_smiling_face: ?
         and dev- as well
         we login to service thru  dev-cloudco.mybluemix.net/login. and your microservice is exposed thru api/ana - did I get it right?
         Yep
         */
        
        completion(nil)
    }
    
}
