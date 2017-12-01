//
//  Staff.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

/// Staff/Actor Model
/// @link http://anilist-api.readthedocs.io/en/latest/staff.html#staff
class Staff: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var dob: Int = 0
    @objc dynamic var name_first: String = ""
    @objc dynamic var name_last: String = ""
    @objc dynamic var name_first_japanese: String = ""
    @objc dynamic var name_last_japanese: String = ""
    @objc dynamic var image_url_lge: String = ""
    @objc dynamic var image_url_med: String = ""
    @objc dynamic var language: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var info: String = ""
    @objc dynamic var role: String?
    
    convenience init?(_ json: JSON) {
        guard let id = json["id"].int, let dob = json["dob"].int else {
            return nil
        }
        self.init()
        self.id = id
        self.dob = dob
        self.name_first = json["name_first"].stringValue
        self.name_last = json["name_last"].stringValue
        self.name_first_japanese = json["name_first_japanese"].stringValue
        self.name_last_japanese = json["name_last_japanese"].stringValue
        self.image_url_lge = json["image_url_lge"].stringValue
        self.image_url_med = json["image_url_med"].stringValue
        self.language = json["language"].stringValue
        self.website = json["website"].stringValue
        self.info = json["info"].stringValue
        self.role = json["role"].string
    }
}

enum StaffType: String {
    case staff, actor
}

/// Small Staff Model
struct StaffSmall {
    var id: Int
    var name_first: String
    var name_last: String
    var image_url_lge: String
    var image_url_med: String
    var language: String
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
        self.language = json["language"].stringValue
        self.role = json["role"].string
    }
}
