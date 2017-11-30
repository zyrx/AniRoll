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

class Genre: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var lastUpdate: Date = Date()
    //let series = LinkingObjects(fromType: Serie.self, property: "genre")
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init?(_ json: JSON) {
        guard let id = json["id"].int else {
            return nil
        }
        self.init()
        self.id = id
        self.name = json["genre"].stringValue
    }
}
