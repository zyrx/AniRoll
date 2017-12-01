//
//  Character.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

enum CharacterType: String {
    case character, staff, actors
}

class Character: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name_first: String = ""
    @objc dynamic var name_last: String = ""
    @objc dynamic var name_japanese: String = ""
    @objc dynamic var name_alt: String = ""
    @objc dynamic var info: String = ""
    @objc dynamic var image_url_lge: String = ""
    @objc dynamic var image_url_med: String = ""
    @objc dynamic var role: String?
    
    convenience init?(_ json: JSON) {
        guard let id = json["id"].int, let name_first = json["name_first"].string else {
            return nil
        }
        self.init()
        self.id = id
        self.name_first = name_first
        self.name_last = json["name_last"].stringValue
        self.name_japanese = json["name_japanese"].stringValue
        self.name_alt = json["name_alt"].stringValue
        self.info = json["info"].stringValue
        self.image_url_lge = json["image_url_lge"].stringValue
        self.image_url_med = json["image_url_med"].stringValue
        self.role = json["role"].string
    }
}

/// Small Character Model
struct CharacterSmall {
    var id: Int
    var name_first: String
    var name_last: String
    var image_url_lge: String
    var image_url_med: String
    var role: String?
    
    init?(_ json: JSON) {
        guard let id = json["id"].int, let name_first = json["name_first"].string else {
            return nil
        }
        self.id = id
        self.name_first = name_first
        self.name_last = json["name_last"].stringValue
        self.image_url_lge = json["image_url_lge"].stringValue
        self.image_url_med = json["image_url_med"].stringValue
        self.role = json["role"].string
    }
}
