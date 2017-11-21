//
//  ScoreDistribution.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class ScoreDistribution: Object {
    @objc dynamic var _10: Int = 0
    @objc dynamic var _20: Int = 0
    @objc dynamic var _30: Int = 0
    @objc dynamic var _40: Int = 0
    @objc dynamic var _50: Int = 0
    @objc dynamic var _60: Int = 0
    @objc dynamic var _70: Int = 0
    @objc dynamic var _80: Int = 0
    @objc dynamic var _90: Int = 0
    @objc dynamic var _100: Int = 0
}
