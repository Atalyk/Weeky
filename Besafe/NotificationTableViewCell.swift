//
//  NotificationCollectionViewCell.swift
//  Besafe
//
//  Created by Admin on 9/1/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    var layerView = UIView()
    var notificationLabel = UILabel()
    var noteLabel = UILabel()
    var dateLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
        
        //rgb(52, 152, 219)
        
        dateLabel = UILabel(frame: CGRect(x: screenBounds.width*0.7, y: 0, width: screenBounds.width*0.3, height: screenBounds.height*0.1))
        dateLabel.font = UIFont(name: "Helvetica-Light", size: screenBounds.width*0.06)
        dateLabel.textAlignment = .Center
        dateLabel.textColor = UIColor.whiteColor()
        self.addSubview(dateLabel)
            
        notificationLabel = UILabel(frame: CGRect(x: screenBounds.width*0.03, y: 0, width: screenBounds.width*0.68, height: screenBounds.height*0.1))
        notificationLabel.font = UIFont(name: "Helvetica-Light", size: screenBounds.width*0.06)
        notificationLabel.textAlignment = .Left
        notificationLabel.textColor = UIColor.blackColor()
        self.addSubview(notificationLabel)
        
        noteLabel = UILabel(frame: CGRect(x: screenBounds.width*0.03, y: self.frame.height*0.6, width: screenBounds.width*0.68, height: self.frame.height))
        noteLabel.text = "Lorem ipsum bal bla bla"
        noteLabel.textColor = UIColor.whiteColor()
        noteLabel.font = UIFont(name: "Helvetica-Light", size: screenBounds.width*0.04)
        noteLabel.textAlignment = .Left
        self.addSubview(noteLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
