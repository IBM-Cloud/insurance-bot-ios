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

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var chatTableView: UITableView!
  
    @IBOutlet var textInput: UITextField!
    @IBOutlet var bottomBarConstraint: NSLayoutConstraint!
    
    var stubdata = [
        [
            "time":"9:30",
            "message":"Lorem ipsum dolor sit amet, consectetur adipiscing elit",
            "from":"server"
        ], [
            "time":"9:31",
            "message":"ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat",
            "from":"me"
        ], [
            "time":"9:32",
            "message":"nulla pariatur",
            "from":"server"
        ], [
            "time":"9:33",
            "message":"Excepteur sint occaecat cupidatat non proident",
            "from":"me"
        ], [
            "time":"9:34",
            "message":"Sed ut perspiciatis unde omnis iste natus error ",
            "from":"server"
        ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        nc.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 200
        refreshAndScrollTable(animated:false)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    
    @IBAction func backButtonPress(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMessage(_ sender: AnyObject) {
        let value = textInput.text
        if ((value?.characters.count)! > 0) {
            //print(value);
            
            //this is mock implementation, will need to be replaced
            stubdata.append(["time":"9:40", "message":value!, "from":"me"])
            refreshAndScrollTable(animated:true)
            
            textInput.text = ""
        }
    }
    
    func messageReceived(message:[String:Any]) {
        
    }
    
    func refreshAndScrollTable(animated:Bool) {
        chatTableView.reloadData()
        chatTableView.scrollToLastRow(animated:animated)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        sendMessage(self)
        return false
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        
        bottomBarConstraint.constant = keyboardSize - 1.0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        bottomBarConstraint.constant = -1
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stubdata.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageData = stubdata[indexPath.row]
        var cell:ChatMessageViewCell? = nil
        if ( messageData["from"] != "me" ) {
            cell = tableView.dequeueReusableCell(withIdentifier: "serverChatViewCell") as? ChatMessageViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "myChatViewCell") as? ChatMessageViewCell
        }
        
        cell?.setMessage(data:messageData)
        
        return cell!
    }
}
