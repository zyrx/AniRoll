//
//  ScoreDistribution.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

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
    
    convenience init?(_ json: JSON) {
        guard let _10 = json["10"].int else {
            return nil
        }
        self.init()
        self._10 = _10
        self._20 = json["20"].intValue
        self._30 = json["30"].intValue
        self._40 = json["40"].intValue
        self._50 = json["50"].intValue
        self._60 = json["60"].intValue
        self._70 = json["70"].intValue
        self._80 = json["80"].intValue
        self._90 = json["90"].intValue
        self._100 = json["100"].intValue
    }
}
