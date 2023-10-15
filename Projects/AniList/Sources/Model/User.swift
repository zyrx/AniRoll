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

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class User: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var display_name: String = ""
    @objc dynamic public var anime_time: Int = 0
    @objc dynamic public var manga_chap: String = ""
    @objc dynamic public var about: String = ""
    @objc dynamic public var list_order: Int = 0
    @objc dynamic public var adult_content: Bool = false
    @objc dynamic public var following: Bool = false
    @objc dynamic public var image_url_lge: String = ""
    @objc dynamic public var image_url_med: String = ""
    @objc dynamic public var image_url_banner: String = ""
    @objc dynamic public var title_language: String = ""
    @objc dynamic public var score_type: Int = 0
    public let custom_list_anime = List<StringObject> ()
    public let custom_list_manga = List<StringObject> ()
    @objc dynamic public var advanced_rating: Bool = false
    public let advanced_rating_names = List<StringObject> ()
    @objc dynamic public var notifications: Int = 0
    
    override static public func primaryKey() -> String? {
        return "id"
    }
    
    convenience public init?(_ json: JSON) {
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
        self.advanced_rating = json["advanced_rating"].boolValue
        self.notifications = json["notifications"].intValue
    }
}
