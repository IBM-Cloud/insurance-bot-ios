//
//  InsetLabel.swift
//  insurance-mobile
//
//  Created by Andrew Trice on 10/12/16.
//  Copyright © 2016 Anton McConville. All rights reserved.
//

import UIKit

class InsetLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawText(in rect: CGRect) {
        let insets:UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    

}
