osrf//
//  DayTableViewCell.swift
//  Besafe
//
//  Created by Admin on 9/4/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    var layerView = UIView()
    var dayLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    func setup() {
        
        self.layer.backgroundColor = UIColor.whiteColor().CGColor
    
        dayLabel = UILabel(frame: CGRect(x: screenBounds.width*0.07, y: 0, width: screenBounds.width, height: screenBounds.height*1/7))
        dayLabel.font = UIFont(name: "Helvetica-Light", size: screenBounds.width*0.08)
        dayLabel.textAlignment = .Left
        dayLabel.textColor = UIColor.whiteColor()
        self.addSubview(dayLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}