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

    func login(email:String, password:String, completion:(AnyObject?)->()) -> Void {
        // perform login, then call completion callback with result 
        
        NSLog("DataManager| email: " + email)
        NSLog("DataManager| password: " + password)
        
        //todo: move to Info.plist
        let target = "http://dev-cloudco.mybluemix.net/login"
        
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
                print("error")
                print(response)
                return
            }
            
            let dataString = String(data: data, encoding: String.Encoding.utf8)
            NSLog("DataManager| dataString :" + dataString!)
            let dictionary = self.convertStringToDictionary(text: dataString!)
            
            if let fname = dictionary?["firstName"] {
                self.firstName = fname as! String
            }
            
            if let lname = dictionary?["lastName"] {
                self.lastName = lname as! String
            }
            
            if let uname = dictionary?["username"] {
                self.userName = uname as! String
            }
            
            if let outcome = dictionary?["outcome"] {
                self.loginStatus = (outcome.isEqual("success"))
                NSLog("DataManager| login status: " + (outcome as! String))
            }
            
        }
        task.resume()

        completion(loginStatus as AnyObject?)
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
    
    func postMessage(message:String, completion:(AnyObject?)->()) -> Void {
        // send chat message, then call completion with result
        
        completion(nil)
    }
    
}
