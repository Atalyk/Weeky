//
//  NotificationObject.swift
//  Besafe
//
//  Created by Admin on 9/2/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class NotificationObject : Object {
    dynamic var title = "Empty"
    dynamic var note = "Empty"
    dynamic var deadline = NSDate()
    dynamic var UUID = ""
    dynamic var url = ""
    dynamic var color = 1
    dynamic var day = ""
}
