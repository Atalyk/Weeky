//
//  DatePicker.swift
//  Besafe
//
//  Created by Admin on 9/2/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import Foundation
import UIKit


class DatePicker: UIView {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    var deadlinePicker = UIDatePicker()
    var layerView = UIView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
            
        deadlinePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height*0.3))
        self.addSubview(deadlinePicker)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}