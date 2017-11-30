//
//  ListStats.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

/// List Stats
/// @link http://anilist-api.readthedocs.io/en/latest/series.html#list-stats
class ListStats: Object {
    @objc dynamic var completed: Int = 0
    @objc dynamic var on_hold: Int = 0
    @objc dynamic var dropped: Int = 0
    @objc dynamic var plan_to_watch: Int = 0
    @objc dynamic var watching: Int = 0
    
    convenience init?(_ json: JSON) {
        guard let completed = json["completed"].int else {
            return nil
        }
        self.init()
        self.completed = completed
        self.on_hold = json["on_hold"].intValue
        self.dropped = json["dropped"].intValue
        self.plan_to_watch = json["plan_to_watch"].intValue
        self.watching = json["watching"].intValue
    }
    var toString: String {
        return String(format:
            "Completed: %@, On hold: %@, Dropped: %@, Plan to watch: %@, Watching: %@",
            self.completed, self.on_hold, self.dropped, self.plan_to_watch, self.watching
        )
    }
}
