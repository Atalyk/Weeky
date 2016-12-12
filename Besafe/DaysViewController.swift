s//
//  DaysViewController.swift
//  Besafe
//
//  Created by Admin on 9/4/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import UIKit

class DaysViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    lazy var tableView = UITableView()
    
    let weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let colors = [UIColor.mondayColor(UIColor())(), UIColor.tuesdayColor(UIColor())(), UIColor.wednesdayColor(UIColor())(), UIColor.thursdayColor(UIColor())(), UIColor.fridayColor(UIColor())(), UIColor.saturdayColor(UIColor())(), UIColor.sundayColor(UIColor())()]
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setup() {
        
        
        tableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: screenBounds.width, height: screenBounds.height))
        tableView.backgroundColor = UIColor(red: 255/255, green: 150/255, blue: 150/255, alpha: 1.0)
        tableView.contentInset = UIEdgeInsetsZero
        tableView.pagingEnabled = false
        tableView.rowHeight = screenBounds.height*1/7
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.registerClass(DayTableViewCell.self, forCellReuseIdentifier: "DayCell")
        self.view.addSubview(tableView)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DayCell", forIndexPath: indexPath) as! DayTableViewCell
        cell.dayLabel.text = weekDays[indexPath.row]
        cell.layer.backgroundColor = colors[indexPath.row].CGColor
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue()) {
            let feedViewController = self.storyboard!.instantiateViewControllerWithIdentifier("FeedViewController") as! FeedViewController
            feedViewController.day = self.weekDays[indexPath.row]
            self.presentViewController(feedViewController, animated:true, completion: nil)
        }
    }

}
