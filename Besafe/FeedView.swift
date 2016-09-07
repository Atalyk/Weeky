//
//  FeedView.swift
//  Besafe
//
//  Created by Admin on 9/1/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import Foundation
import UIKit

class FeedView : UIView {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    lazy var tableView = UITableView()
    lazy var textView = UITextView()
    lazy var imageView = UIImageView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: screenBounds.width, height: screenBounds.height))
        tableView.contentInset = UIEdgeInsetsZero
        tableView.pagingEnabled = false
        tableView.registerClass(NotificationTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.addSubview(tableView)
        
        imageView = UIImageView(frame: CGRect(x: screenBounds.width*0.35, y: screenBounds.height*0.29, width: screenBounds.width*0.3, height: screenBounds.width*0.3))
        imageView.image = UIImage(named: "checked")
        self.addSubview(imageView)
        
        textView = UITextView(frame: CGRect(x: screenBounds.width*0.1, y: screenBounds.height*0.45, width: screenBounds.width*0.8, height: screenBounds.height*0.3))
        textView.font = UIFont(name: "Helvetica-Light", size: screenBounds.width*0.04)
        textView.textAlignment = .Center
        textView.editable = false
        textView.text = "There aren't any notes that currently available. Swipe right to add a new note or swipe left to return."
        self.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}