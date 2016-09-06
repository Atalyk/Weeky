//
//  Tags.swift
//  Besafe
//
//  Created by Admin on 9/5/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import Foundation
import UIKit

class Tags : UIView {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    var tagOneButton = UIButton()
    var tagTwoButton = UIButton()
    var tagThreeButton = UIButton()
    var tagFourButton = UIButton()
    var tagFiveButton = UIButton()
    var tagSixButton = UIButton()
    var tagSevenButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        let distance = (screenBounds.width - 210)*1/8
        
        tagOneButton = UIButton(frame: CGRect(x: distance, y: 0, width: 30, height: 30))
        tagOneButton.layer.backgroundColor = UIColor.mondayColor(UIColor())().CGColor
        tagOneButton.layer.cornerRadius = 15
        tagOneButton.tag = 1
        self.addSubview(tagOneButton)
        
        tagTwoButton = UIButton(frame: CGRect(x: distance*2+30, y: 0, width: 30, height: 30))
        tagTwoButton.layer.backgroundColor = UIColor.tuesdayColor(UIColor())().CGColor
        tagTwoButton.layer.cornerRadius = 15
        tagTwoButton.tag = 2
        self.addSubview(tagTwoButton)
        
        tagThreeButton = UIButton(frame: CGRect(x: distance*3+60, y: 0, width: 30, height: 30))
        tagThreeButton.layer.backgroundColor = UIColor.wednesdayColor(UIColor())().CGColor
        tagThreeButton.layer.cornerRadius = 15
        tagThreeButton.tag = 3
        self.addSubview(tagThreeButton)
        
        tagFourButton = UIButton(frame: CGRect(x: distance*4+90, y: 0, width: 30, height: 30))
        tagFourButton.layer.backgroundColor = UIColor.thursdayColor(UIColor())().CGColor
        tagFourButton.layer.cornerRadius = 15
        tagFourButton.tag = 4
        self.addSubview(tagFourButton)
        
        tagFiveButton = UIButton(frame: CGRect(x: distance*5+120, y: 0, width: 30, height: 30))
        tagFiveButton.layer.backgroundColor = UIColor.fridayColor(UIColor())().CGColor
        tagFiveButton.layer.cornerRadius = 15
        tagFiveButton.tag = 5
        self.addSubview(tagFiveButton)
        
        tagSixButton = UIButton(frame: CGRect(x: distance*6+150, y: 0, width: 30, height: 30))
        tagSixButton.layer.backgroundColor = UIColor.saturdayColor(UIColor())().CGColor
        tagSixButton.layer.cornerRadius = 15
        tagSixButton.tag = 6
        self.addSubview(tagSixButton)
        
        tagSevenButton = UIButton(frame: CGRect(x: distance*7+180, y: 0, width: 30, height: 30))
        tagSevenButton.layer.backgroundColor = UIColor.sundayColor(UIColor())().CGColor
        tagSevenButton.layer.cornerRadius = 15
        tagSevenButton.tag = 7
        self.addSubview(tagSevenButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}