//
//  Genre.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/24/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Genre: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var name: String = ""
    @objc dynamic public var lastUpdate: Date = Date()
    
    override static public func primaryKey() -> String? {
        return "id"
    }
    
    convenience public init?(_ json: JSON) {
        guard let id = json["id"].int else {
            return nil
        }
        self.init()
        self.id = id
        self.name = json["genre"].stringValue
    }
}
