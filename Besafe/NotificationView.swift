//
//  MainView.swift
//  Besafe
//
//  Created by Admin on 8/31/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import Foundation
import UIKit

class NotificationView: UIView {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    var deadlinePicker = UIDatePicker()
    
    var submitButton = UIButton()
    var datePickerButton = UIButton()
    var uploadImageButton = UIButton()
    var tagButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        self.backgroundColor = UIColor.whiteColor()
    
        submitButton = UIButton(frame: CGRect(x: screenBounds.width*0.69, y: screenBounds.height*0.92, width: screenBounds.width*0.25, height: 40))
        submitButton.layer.cornerRadius = 10
        submitButton.layer.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0).CGColor
        submitButton.setTitle("Submit", forState: .Normal)
        submitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.addSubview(submitButton)
        
        datePickerButton = UIButton(frame: CGRect(x: screenBounds.width*0.05, y: screenBounds.height*0.92, width: 40, height: 40))
        datePickerButton.setImage(UIImage(named: "cal"), forState: .Normal)
        datePickerButton.contentMode = .Center
        self.addSubview(datePickerButton)
        
        uploadImageButton = UIButton(frame: CGRect(x: screenBounds.width*0.2, y: screenBounds.height*0.92, width: 40, height: 40))
        uploadImageButton.setImage(UIImage(named: "pic"), forState: .Normal)
        uploadImageButton.contentMode = .Center
        self.addSubview(uploadImageButton)
        
        tagButton = UIButton(frame: CGRect(x: screenBounds.width*0.35, y: screenBounds.height*0.92, width: 40, height: 40))
        tagButton.setImage(UIImage(named: "tag"), forState: .Normal)
        tagButton.contentMode = .Center
        self.addSubview(tagButton)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}