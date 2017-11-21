//
//  Serie.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

/// A series is either an anime or manga. {series_type} is either ‘anime’ or ‘manga’.
class Serie: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var series_type: String = ""
    @objc dynamic var title_romaji: String = ""
    @objc dynamic var title_english: String = ""
    @objc dynamic var title_japanese: String = ""
    @objc dynamic var start_date: String?
    @objc dynamic var end_date: String?
    @objc dynamic var start_date_fuzzy: Int = 0
    @objc dynamic var end_date_fuzzy: Int = 0
    @objc dynamic var season: Int = 0
    @objc dynamic var desc: String?
    let synonyms = List<StringObject>()
    let genres = List<StringObject>()
    @objc dynamic var adult: Bool = false
    @objc dynamic var average_score: Double = 0.0
    @objc dynamic var popularity: Int = 0
    @objc dynamic var favourite: Bool = false
    @objc dynamic var image_url_sml: String = ""
    @objc dynamic var image_url_med: String = ""
    @objc dynamic var image_url_lge: String = ""
    @objc dynamic var image_url_banner: String?
    @objc dynamic var updated_at: Int = 0
    @objc dynamic var score_distribution: ScoreDistribution?
    @objc dynamic var list_stats: ListStats?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init?(_ json: JSON) {
        guard let id = json["id"].int else {
            return nil
        }
        self.init()
        self.id = id
        self.series_type = json["series_type"].stringValue
        self.title_romaji = json["title_romaji"].stringValue
        self.title_english = json["title_english"].stringValue
        self.title_japanese = json["title_japanese"].stringValue
        self.start_date = json["start_date"].string
        self.end_date = json["end_date"].string
        self.start_date_fuzzy = json["start_date_fuzzy"].intValue
        self.end_date_fuzzy = json["end_date_fuzzy"].intValue
        self.season = json["season"].intValue
        self.desc = json["description"].string
        //self.synonyms = json["synonyms"].stringValue
        //self.genres = json["genres"].stringValue
        self.adult = json["adult"].boolValue
        self.average_score = json["average_score"].doubleValue
        self.popularity = json["popularity"].intValue
        self.favourite = json["favourite"].boolValue
        self.image_url_sml = json["image_url_sml"].stringValue
        self.image_url_med = json["image_url_med"].stringValue
        self.image_url_lge = json["image_url_lge"].stringValue
        self.image_url_banner = json["image_url_banner"].string
        self.updated_at = json["updated_at"].intValue
        //self.score_distribution = json["score_distribution"].stringValue
        //self.list_stats = json["list_stats"].stringValue
    }
}

struct NewSerie {
    /// SerieType
    var type: SerieType
    /// Anime/Manga id of list item
    var id: Int?
    /// Anime: "watching" || "completed" || "on-hold" || "dropped" || "plan to watch"
    /// Manga: "reading" || "completed" || "on-hold" || "dropped" || "plan to read"
    var list_status: ListStatus
    /// List score type: The AniList API will automatically convert and output the correct score format for the user’s type.
    var score: ListScore
    /// Score Raw: Will return the unformatted 0-100 int of the users score.
    var score_raw: Int
    /// Anime only
    var episodes_watched: Int?
    /// Anime only
    var rewatched: Int?
    /// Manga only
    var volumes_read: Int?
    /// Manga only
    var chapters_read: Int?
    /// Manga only
    var reread: Int?
    /// Notes
    var notes: String
    /// Comma separated scores, same order as advanced_rating_names
    var advanced_rating_scores: String
    /// Comma separated 1 or 0, same order as custom_list_anime
    var custom_lists: String
    /// Hidden
    var hidden_default: Bool
}

@objc enum SerieType: Int {
    case anime, manga
    var name: String {
        switch self {
        case .anime: return "animelist"
        case .manga: return "mangalist"
        }
    }
}

enum SerieSeason: String {
    case winter, spring, summer, fall
}

enum SerieStatus {
    case finished, currently, notYet, cancelled
    var anime: String {
        switch self {
        case .finished: return "finished airing"
        case .currently: return "currently airing"
        case .notYet: return "not yet aired"
        case .cancelled: return "cancelled"
        }
    }
    var manga: String {
        switch self {
        case .finished: return "finished publishing"
        case .currently: return "publishing"
        case .notYet: return "not yet published"
        case .cancelled: return "cancelled"
        }
    }
}

enum ListStatus: String {
    case watching = "watching"
    case completed = "completed"
    case onHold = "on-hold"
    case droped = "dropped"
    case planToWatch = "plan to watch"
    case reading = "reading"
    case planToRead = "plan to read"
}

/// List List Scores
/// @link http://anilist-api.readthedocs.io/en/latest/lists.html#list-scores
enum ListScore {
    case _10(point: Int)
    case _100(point: Int)
    /// 1 : 1-29, 2 : 30-49, 3 : 50-69, 4 : 70-89, 5 : 90-100
    case _5(star: Int)
    /// :( : 1-30, :| : 31-60, :) : 61-100
    case _3(smile: String)
    case _10Decimal(point: Float)
    var name: String {
        switch self {
        case ._10(_): return "Point (0-10 int)"
        case ._100(_): return "Point (0-100 int)"
        case ._5(_): return "(0-5 int)"
        case ._3(_): return "Smiles (\":(\",\":|\",\":)\" String)"
        case ._10Decimal(_): return "Point decimal (0.0 - 10.0 Float)"
        }
    }
}
enum ListScoreOrder {
    case score, alphabetical
}
