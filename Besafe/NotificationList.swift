//
//  NotifsList.swift
//  Besafe
//
//  Created by Admin on 8/31/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class NotificationList {
    class var sharedInstance : NotificationList {
        struct Static {
            static let instance : NotificationList = NotificationList()
        }
        return Static.instance
    }
    
    //private let NOTIFS_KEY = "notifs"
    
    let realm = try! Realm()
    var notificationObjects = [NotificationObject]()
    
    func addNotification(notify: NotificationObject) {
        
        try! realm.write {
            realm.add(notify)
        }
        
 
        let notification = UILocalNotification()
        notification.alertBody = "\(notify.title) is Overdue"
        notification.alertAction = "open"
        notification.fireDate = notify.deadline
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["title": notify.title, "UUID": notify.UUID]
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func allNotifications(day: String) -> [NotificationObject] {
        
        notificationObjects.removeAll()
        
        do {
            let notificationRealms = realm.objects(NotificationObject).filter("day = '\(day)'")
            for notificationObject in notificationRealms {
                notificationObjects.append(notificationObject)
            }
        } catch {
            print("Error")
        }
        
        return notificationObjects
    }
    
    func removeNotification(notify: NotificationObject) {
        
        let scheduleNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        guard scheduleNotifications != nil else {return}
        
        for notification in scheduleNotifications! {
            if (notification.userInfo!["UUID"] as! String == notify.UUID) {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
        
        try! realm.write({ () -> Void in
            realm.delete(notify)
        })
    }

}
