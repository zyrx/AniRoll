//
//  ListStats.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class ListStats: Object {
    @objc dynamic var completed: Int = 0
    @objc dynamic var on_hold: Int = 0
    @objc dynamic var dropped: Int = 0
    @objc dynamic var plan_to_watch: Int = 0
    @objc dynamic var watching: Int = 0
}
