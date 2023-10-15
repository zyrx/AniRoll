//
//  Manga.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Manga: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var title_romaji: String = ""
    @objc dynamic public var title_japanese: String = ""
    @objc dynamic public var title_english: String = ""
    @objc dynamic public var type: String = ""
    @objc dynamic public var start_date: String = ""
    @objc dynamic public var end_date: String = ""
    let synonyms = List<StringObject>()
    @objc dynamic public var desc: String = ""
    let genres = List<StringObject>()
    @objc dynamic public var image_url_lge: String = ""
    @objc dynamic public var image_url_med: String = ""
    @objc dynamic public var image_url_banner: String?
    @objc dynamic public var publishing_status: String = ""
    @objc dynamic public var average_score: Double = 0.0
    @objc dynamic public var total_chapters: Int = 0
    @objc dynamic public var total_volumes: Int = 0
    @objc dynamic public var adult: Bool = false
    @objc dynamic public var popularity: Int = 0
    @objc dynamic public var relation_type: String?
    @objc dynamic public var role: String?
    @objc dynamic public var list_stats: ListStats?
    
    override static public func primaryKey() -> String? {
        return "id"
    }
    
    convenience public init?(_ json: JSON) {
        guard let id = json["id"].int else {
            return nil
        }
        self.init()
        self.id = id
        self.title_romaji = json["title_romaji"].stringValue
        self.title_english = json["title_english"].stringValue
        self.title_japanese = json["title_japanese"].stringValue
        self.start_date = json["start_date"].stringValue
        self.end_date = json["end_date"].stringValue
        //self.synonyms = json["synonyms"].stringValue
        self.desc = json["description"].stringValue
        //self.genres = json["genres"].stringValue
        self.average_score = json["average_score"].doubleValue
        self.total_chapters = json["total_chapters"].intValue
        self.total_volumes = json["total_volumes"].intValue
        self.adult = json["adult"].boolValue
        self.popularity = json["popularity"].intValue
        self.image_url_med = json["image_url_med"].stringValue
        self.image_url_lge = json["image_url_lge"].stringValue
        self.image_url_banner = json["image_url_banner"].string
    }
}
