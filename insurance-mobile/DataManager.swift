//
//  DataManager.swift
//  insurance-mobile
//
//  Created by Andrew Trice on 10/11/16.
//  Copyright © 2016 Anton McConville. All rights reserved.
//

import Foundation

class DataManager {
    static let sharedInstance = DataManager();


    func login(email:String, password:String, completion:(AnyObject?)->()) -> Void {
        // perform login, then call completion callback with result 
        completion(nil)
    }
    
    func postMessage(message:String, completion:(AnyObject?)->()) -> Void {
        // send chat message, then call completion with result
        
        completion(nil)
    }
    
}
