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

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var chatTableView: UITableView!
  
    @IBOutlet var bottomBarConstraint: NSLayoutConstraint!
    
    let stubdata = [
        [
            "time":"9:30",
            "message":"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation",
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
            "message":"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
            "from":"me"
        ], [
            "time":"9:34",
            "message":"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?",
            "from":"server"
        ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        nc.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        chatTableView.rowHeight = UITableViewAutomaticDimension
        chatTableView.estimatedRowHeight = 60
        chatTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    
    @IBAction func backButtonPress(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
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
        if ( messageData["from"] == "me" ) {
            cell = tableView.dequeueReusableCell(withIdentifier: "serverChatViewCell") as? ChatMessageViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "myChatViewCell") as? ChatMessageViewCell
        }
        
        cell?.setMessage(data:messageData)
        
        return cell!
    }
}
