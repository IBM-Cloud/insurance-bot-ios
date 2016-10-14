//
//  DataManager.swift
//  insurance-mobile
//
//  Created by Andrew Trice on 10/11/16.
//  Updates by Marek Sadowski on 10/13/16.
//  Copyright © 2016 Anton McConville. All rights reserved.
//

import Foundation
import SwiftyJSON

class DataManager {
    static let sharedInstance = DataManager();
    var firstName = ""
    var lastName = ""
    var userName = ""
    var loginStatus = false
    var baseURL = ""
    var loginURL = ""
    var chatURL = ""

    func login(email:String, password:String, completion:@escaping (Bool?)->()) -> Void {
        // perform login, then call completion callback with result 
        
        NSLog("DataManager| email: " + email)
        NSLog("DataManager| password: " + password)
        
        //parameters moved to configureMe.plist
        readConfigureMePList()
        let target = (!loginURL.contains("") ? loginURL : "http://cloudco.mybluemix.net/login")
        NSLog("DataManager| using loginURL: " + target)
        
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
            
            let json = JSON(data: data)
            
            if let fname = json["fname"].string {
                self.firstName = fname
            }
            
            if let lname = json["lname"].string {
                self.lastName = lname
            }
            
            if let username = json["username"].string {
                self.userName = username
            }
            
            if let outcome = json["outcome"].string {
                self.loginStatus = (outcome.isEqual("success"))
                NSLog("DataManager| login status: " + (outcome))
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
        baseURL = dictArray["url"]!
        loginURL = dictArray["url"]!+dictArray["login"]!
        chatURL = dictArray["url"]!+dictArray["ana"]!
        NSLog("DataManager| the baseURL: " + baseURL)
        
    }
    
    func postMessage(message:String?, context:JSON?, completion:@escaping (JSON?)->()) -> Void {
        
        let url:URL = URL(string: chatURL)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramJSON:JSON = [:]
        if let message = message {
            paramJSON["text"].string = message
        }
        if let context = context {
            paramJSON["context"] = context
        }
        
        let paramString = paramJSON.rawString()!
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = session.dataTask(with: request as URLRequest) {
            
            (data, response, error) in
            
           guard let data = data, let _:URLResponse = response  , error == nil else {
                NSLog("DataManager| postMessage error :")
                print(response)
                completion(nil)
                return
            }
            
            let json = JSON(data: data)
            completion(json)
        }
        task.resume()
    }
    
}
