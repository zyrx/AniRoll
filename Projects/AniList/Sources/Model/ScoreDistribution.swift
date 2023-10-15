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

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class ScoreDistribution: Object {
    @objc dynamic public var _10: Int = 0
    @objc dynamic public var _20: Int = 0
    @objc dynamic public var _30: Int = 0
    @objc dynamic public var _40: Int = 0
    @objc dynamic public var _50: Int = 0
    @objc dynamic public var _60: Int = 0
    @objc dynamic public var _70: Int = 0
    @objc dynamic public var _80: Int = 0
    @objc dynamic public var _90: Int = 0
    @objc dynamic public var _100: Int = 0
    
    convenience public init?(_ json: JSON) {
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
    
    public var toString: String {
        return String(format:
            "[10: %d], [20: %d], [30: %d], [40: %d], [50: %d], [60: %d], [70: %d], [80: %d], [90: %d], [100: %d]",
            self._10, self._20, self._30, self._40, self._50, self._60, self._70, self._80, self._90, self._100
        )
    }
}
