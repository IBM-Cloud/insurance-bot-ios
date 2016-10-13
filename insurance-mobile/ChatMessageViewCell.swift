//
//  ChatMessageViewCell.swift
//  insurance-mobile
//
//  Created by Andrew Trice on 10/12/16.
//  Copyright © 2016 Anton McConville. All rights reserved.
//

import UIKit

class ChatMessageViewCell: UITableViewCell {

    @IBOutlet public var messageLabel: UILabel!
    @IBOutlet public var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setMessage(data: [String:Any]) {
        timeLabel.text = "\(data["time"]!)"
        messageLabel.text = "\(data["message"]!)"
        
        messageLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        messageLabel.numberOfLines = 0;
        messageLabel.sizeToFit()
    }

}
