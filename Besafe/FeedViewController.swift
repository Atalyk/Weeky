//
//  FeedViewController.swift
//  Besafe
//
//  Created by Admin on 9/1/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let screenBounds = UIScreen.mainScreen().bounds
    
    var feedView = FeedView()
    var index = 0
    var notify = NotificationObject()
    
    let colors = [UIColor.mondayColor(UIColor())(), UIColor.tuesdayColor(UIColor())(), UIColor.wednesdayColor(UIColor())(), UIColor.thursdayColor(UIColor())(), UIColor.fridayColor(UIColor())(), UIColor.saturdayColor(UIColor())(), UIColor.sundayColor(UIColor())()]
    
    var day = ""
    
    var refreshControl: UIRefreshControl!
    
    var allNotifications: [NotificationObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FeedViewController.refreshList), name: "RefreshList", object: nil)
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Helvetica", size: screenBounds.width*0.05)!
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.edgesForExtendedLayout = UIRectEdge.None
        self.title = "Notifications"
        self.automaticallyAdjustsScrollViewInsets = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        refreshList()
    }
    
    func refreshList() {
  
        allNotifications = NotificationList.sharedInstance.allNotifications(day).reverse()
        
        if (allNotifications.count >= 64) {
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        feedView.tableView.reloadData()
        
        if allNotifications.count > 0 {
            feedView.imageView.hidden = true
            feedView.textView.hidden = true
        } else {
            feedView.imageView.hidden = false
            feedView.textView.hidden = false
        }
        
    }
    
    func setup() {
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedViewController.pullPresentViewController), forControlEvents: .ValueChanged)
        
        feedView = FeedView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height))
        feedView.tableView.delegate = self
        feedView.tableView.dataSource = self
        feedView.tableView.addSubview(refreshControl)
        feedView.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //feedView.tableView.rowHeight = screenBounds.height*0.1
        self.view.addSubview(feedView)
    }
    
    func pullPresentViewController() {
        let VC = self.storyboard!.instantiateViewControllerWithIdentifier("AddNotificationViewController") as! AddNotificationViewController
        VC.day = day
        self.presentViewController(VC, animated:true, completion: nil)
        refreshControl.endRefreshing()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNotifications.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = feedView.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NotificationTableViewCell
        let notificationObject = allNotifications[indexPath.row] as NotificationObject
        
        if notificationObject.title == "" {
            cell.notificationLabel.text = "No title"
        } else {
            cell.notificationLabel.text = notificationObject.title as String
        }
       

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "H:mm a"
        
        cell.dateLabel.text = dateFormatter.stringFromDate(notificationObject.deadline)
        cell.dateLabel.textColor = colors[notificationObject.color-1]
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        notify = allNotifications[indexPath.row] as NotificationObject
        
        let notificationViewController = self.storyboard!.instantiateViewControllerWithIdentifier("AddNotificationViewController") as! AddNotificationViewController
        
        notificationViewController.titleNotify = notify.title
        notificationViewController.noteNotify = notify.note
        //notificationViewController.imagePath = notify.imagePath
        notificationViewController.day = notify.day
        notificationViewController.url = notify.url
        
        self.presentViewController(notificationViewController, animated:true, completion: nil)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .Destructive, title: "Delete") { (action, indexPath) in
        // delete item at indexPath
            let item = self.allNotifications.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            NotificationList.sharedInstance.removeNotification(item)
            self.navigationItem.rightBarButtonItem!.enabled = true
        }
        
        delete.backgroundColor = UIColor(red: 255/255, green: 150/255, blue: 150/255, alpha: 1.0)

        return [delete]
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if UIScreen.mainScreen().bounds.width < UIScreen.mainScreen().bounds.height {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                
                switch swipeGesture.direction {
                case UISwipeGestureRecognizerDirection.Left:
                    let addNotificationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("AddNotificationViewController") as! AddNotificationViewController
                    addNotificationViewController.day = day
                    self.presentViewController(addNotificationViewController, animated: true, completion: nil)
                case UISwipeGestureRecognizerDirection.Right:
                    let daysViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DaysViewController") as! DaysViewController
                    self.presentViewController(daysViewController, animated: true, completion: nil)
                default:
                    break
                }
            }
        }
    }

}
