//
//  User.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class User: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var display_name: String = ""
    @objc dynamic var anime_time: Int = 0
    @objc dynamic var manga_chap: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var list_order: Int = 0
    @objc dynamic var adult_content: Bool = false
    @objc dynamic var following: Bool = false
    @objc dynamic var image_url_lge: String = ""
    @objc dynamic var image_url_med: String = ""
    @objc dynamic var image_url_banner: String = ""
    @objc dynamic var title_language: String = ""
    @objc dynamic var score_type: Int = 0
    let custom_list_anime = List<StringObject> ()
    let custom_list_manga = List<StringObject> ()
    @objc dynamic var advanced_rating: Bool = false
    let advanced_rating_names = List<StringObject> ()
    @objc dynamic var notifications: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init?(_ json: JSON) {
        guard let id = json["id"].int, let display_name = json["display_name"].string else {
            return nil
        }
        self.init()
        self.id = id
        self.display_name = display_name
        self.anime_time = json["anime_time"].intValue
        self.manga_chap = json["manga_chap"].stringValue
        self.about = json["about"].stringValue
        self.list_order = json["list_order"].intValue
        self.adult_content = json["adult_content"].boolValue
        self.following = json["following"].boolValue
        self.image_url_lge = json["image_url_lge"].stringValue
        self.image_url_med = json["image_url_med"].stringValue
        self.image_url_banner = json["image_url_banner"].stringValue
        self.title_language = json["title_language"].stringValue
        self.score_type = json["score_type"].intValue
        // @TODO: custom_list_anime
        // @TODO: custom_list_manga
        self.advanced_rating = json["advanced_rating"].boolValue
        // @TODO: self.advanced_rating_names = json["advanced_rating_names"].boolValue
        self.notifications = json["notifications"].intValue
    }
}
