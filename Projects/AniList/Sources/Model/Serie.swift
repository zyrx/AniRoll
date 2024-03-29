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
@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Serie: Object {
    // MARK: - Serie model values
    /// id: Int - Unique serie identifier
    @objc dynamic public var id: Int = 0
    /// series_type: String -  "anime" or "manga".
    @objc dynamic public var series_type: String = ""
    /// title_romaji: String - Romanization of Japanese title. i.e. "Kangoku Gakuen".
    @objc dynamic public var title_romaji: String = ""
    /// title_english: String - When no English title is available, the romaji title will fill this value. i.e. "Prison School"
    @objc dynamic public var title_english: String = ""
    /// title_japanese: String - When no Japanese title is available, the romaji title will fill this value. i.e. " 進撃の巨人 総集編"
    @objc dynamic public var title_japanese: String = ""
    /// media_type[type]: String - Media Type: "TV" || "TV Short" || "Movie" || "Special" || "OVA" || "ONA" || "Music" || "Manga" || "Novel" || "One Shot" || "Doujin" || "Manhua" || "Manhwa"
    @objc dynamic public var media_type: String = ""
    /// start_date: String? - Deprecated Start Date
    @available(*, deprecated:3.0, message:"Use start_date_fuzzy instead.")
    @objc dynamic public var start_date: String?
    /// end_date: String? - Deprecated End Date
    @available(*, deprecated:3.0, message:"Use end_date_fuzzy instead.")
    @objc dynamic public var end_date: String?
    /// start_date_fuzzy: Int? - Start Date: 8 digit long integer representing YYYYMMDD. i.e. "20070215"
    @objc dynamic public var start_date_fuzzy: Int = 0
    /// end_date_fuzzy: Int? - End Date: 8 digit long integer representing YYYYMMDD. i.e. "20070215"
    @objc dynamic public var end_date_fuzzy: Int = 0
    /// season: Int? - Serie Season: First 2 numbers are the year (16 is 2016). Last number is the season starting at 1 (3 is Summer).
    @objc dynamic public var season: Int = 0
    /// description: String? - Description of serie.
    @objc dynamic public var desc: String?
    /// synonyms: [String] - Alternative titles. i.e. [“The Prison School”].
    public let synonyms = List<StringObject>()
    /// genres: [String] - Serie Genres. i.e. [“Action”, “Fantasy”, “Sci-Fi”]
    public let genres = List<StringObject>()
    /// adult: Bool - True for adult series (Hentai). This does not include ecchi
    @objc dynamic public var adult: Bool = false
    /// average_score: Double - Serire's averange scroe [0-100]. i.e. 67.8
    @objc dynamic public var average_score: Double = 0.0
    /// popularity: Int - Number of users with series on their list. i.e. 15340
    @objc dynamic public var popularity: Int = 0
    /// favourite: Bool - True if the current authenticated user has favorited the series. False if not authenticated.
    @objc dynamic public var favourite: Bool = false
    /// image_url_sml: String - Image url. 24x39* (Not available for manga). i.e. "http://cdn.anilist.co/img/dir/anime/sml/9756.jpg"
    @objc dynamic public var image_url_sml: String = ""
    /// image_url_med: String - Image url. 93x133*. i.e. "http://cdn.anilist.co/img/dir/anime/med/9756.jpg"
    @objc dynamic public var image_url_med: String = ""
    /// image_url_lge: String - Image url. 225x323*. i.e. "http://cdn.anilist.co/img/dir/anime/reg/9756.jpg"
    @objc dynamic public var image_url_lge: String = ""
    /// image_url_banner: String? - Image url. 1720x390*. i.e. "http://cdn.anilist.co/img/dir/anime/banner/477.jpg "
    @objc dynamic public var image_url_banner: String?
    /// updated_at: Int - Last time the series data was modified (Unix timestamp). i.e. 1470913937
    @objc dynamic public var updated_at: Int = 0
    /// score_distribution: [] - Distribution object [0 - 100]
    @objc dynamic public var score_distribution: ScoreDistribution?
    /// list_stats: [] - List Stats object. i.e. {"completed": 326, "on_hold": 2071, "dropped": 2158, "plan_to_watch": 446, "watching": 5758 }
    @objc dynamic public var list_stats: ListStats?
    /// lastUpdate: Date - Object update information
    @objc dynamic public var lastUpdate: Date = Date()
    
    // MARK: - Anime model only values
    /// total_episodes: Int - Number of episodes in series season (0 if unknown).
    @objc dynamic public var total_episodes: Int = 0
    /// duration: Int? - Minutes in the average anime episode.
    @objc dynamic public var duration: Int = 0
    /// airing_status: String? - Current airing status of the anime: "finished airing" || "currently airing" || "not yet aired" || "cancelled"
    @objc dynamic public var airing_status: String = ""
    /// youtube_id: String? - Youtube video id. i.e. JIKFtTMvNSg
    @objc dynamic public var youtube_id: String?
    /// hashtag: String? Offical series twitter hashtag. i.e. #shingeki
    @objc dynamic public var hashtag: String?
    /// source: String? - The source adaption media type: "Original" || "Manga" || "Light Novel" || "Visual Novel" || "Video Game" || "Other"
    @objc dynamic public var source: String?
    /// airing_stats: [String]
    @objc dynamic public var airing: Airing?
    
    // MARK: - Manga model only values
    /// total_chapters: Int - Number of total chapters in the manga (0 if unknown).
    @objc dynamic public var total_chapters: Int = 0
    /// total_volumes: Int - Number of total volumes in the manga (0 if unknown).
    @objc dynamic public var total_volumes: Int = 0
    /// publishing_status: String? - Current publishing status of the manga: "finished publishing" || "publishing" || "not yet published" || "cancelled"
    @objc dynamic public var publishing_status: String = ""
    
    // MARK: -
    public var `type`: SerieType {
        return SerieType(from: self.series_type)
    }
    
    public var media: Media? {
        return Media(from: self.media_type)
    }
    
    public var startDate: String {
        guard self.start_date_fuzzy > 0 else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(self.start_date_fuzzy))
        return date.toString(dateFormat: "dd-MMM-yyyy")
    }
    
    public var endDate: String {
        guard self.end_date_fuzzy > 0 else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(self.start_date_fuzzy))
        return date.toString(dateFormat: "dd-MMM-yyyy")
    }
    
    public var seasonString: String {
        let year = Int(self.season / 10)
        guard let serieSeason = SerieSeason(rawValue: self.season - (year * 10)) else {
            return ""
        }
        return String(format: "%@ @d", serieSeason.name, year + 2000)
    }
    
    public var serieStatus: SerieStatus {
        if case .anime = self.type {
            return SerieStatus(from: self.airing_status)
        }
        if case .manga = self.type {
            return SerieStatus(from: self.publishing_status)
        }
        return .unknow
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    convenience public init?(_ json: JSON) {
        guard let id = json["id"].int else {
            return nil
        }
        self.init()
        self.id = id
        self.series_type = json["series_type"].stringValue
        self.title_romaji = json["title_romaji"].stringValue
        self.title_english = json["title_english"].stringValue
        self.title_japanese = json["title_japanese"].stringValue
        self.media_type = json["type"].stringValue
        self.start_date = json["start_date"].string
        self.end_date = json["end_date"].string
        self.start_date_fuzzy = json["start_date_fuzzy"].intValue
        self.end_date_fuzzy = json["end_date_fuzzy"].intValue
        self.season = json["season"].intValue
        self.desc = json["description"].string
        for item in json["synonyms"].arrayValue {
            if let synonym = item.string {
                self.synonyms.append(StringObject(synonym))
            }
        }
        for item in json["genres"].arrayValue {
            if let genre = item.string {
                self.genres.append(StringObject(genre))
            }
        }
        self.adult = json["adult"].boolValue
        self.average_score = json["average_score"].doubleValue
        self.popularity = json["popularity"].intValue
        self.favourite = json["favourite"].boolValue
        self.image_url_sml = json["image_url_sml"].stringValue
        self.image_url_med = json["image_url_med"].stringValue
        self.image_url_lge = json["image_url_lge"].stringValue
        self.image_url_banner = json["image_url_banner"].string
        self.updated_at = json["updated_at"].intValue
        if let score_distribution = ScoreDistribution(json["score_distribution"]) {
            self.score_distribution = score_distribution
        }
        if let list_stats = ListStats(json["list_stats"]) {
            self.list_stats = list_stats
        }
    }
}

public struct NewSerie {
    /// SerieType
    public var type: SerieType
    /// Anime/Manga id of list item
    public var id: Int?
    /// Anime: "watching" || "completed" || "on-hold" || "dropped" || "plan to watch"
    /// Manga: "reading" || "completed" || "on-hold" || "dropped" || "plan to read"
    public var list_status: ListStatus
    /// List score type: The AniList API will automatically convert and output the correct score format for the user’s type.
    public var score: ListScore
    /// Score Raw: Will return the unformatted 0-100 int of the users score.
    public var score_raw: Int
    /// Anime only
    public var episodes_watched: Int?
    /// Anime only
    public var rewatched: Int?
    /// Manga only
    public var volumes_read: Int?
    /// Manga only
    public var chapters_read: Int?
    /// Manga only
    public var reread: Int?
    /// Notes
    public var notes: String
    /// Comma separated scores, same order as advanced_rating_names
    public var advanced_rating_scores: String
    /// Comma separated 1 or 0, same order as custom_list_anime
    public var custom_lists: String
    /// Hidden
    public var hidden_default: Bool
}

@objc public enum SerieType: Int, CaseIterable {
    case anime, manga, unknow
    
    public var name: String {
        switch self {
        case .anime: return "anime"
        case .manga: return "manga"
        case .unknow: return ""
        }
    }
    
    public var list: String {
        switch self {
        case .anime: return "animelist"
        case .manga: return "mangalist"
        case .unknow: return ""
        }
    }
    
    public var toString: String {
        switch self {
        case .anime: return "Anime"
        case .manga: return "Manga"
        case .unknow: return ""
        }
    }
    
    public init(from string: String) {
        let type = SerieType.allCases.first {
            $0.name == string
        }
        self = type ?? .unknow
    }
}

public enum SerieSeason: Int {
    case winter = 1, spring, summer, fall
    public var name: String {
        switch self {
        case .winter: return "Winter"
        case .spring: return "Spring"
        case .summer: return "Summer"
        case .fall: return "Fall"
        }
    }
}

public enum SerieStatus: Int, CaseIterable {
    case finished, currently, notYet, cancelled, unknow
    
    public var anime: String {
        switch self {
        case .finished: return "Finished airing"
        case .currently: return "Currently airing"
        case .notYet: return "Not yet aired"
        case .cancelled: return "Cancelled"
        case .unknow: return "Unknow"
        }
    }
    
    public var manga: String {
        switch self {
        case .finished: return "Finished publishing"
        case .currently: return "Publishing"
        case .notYet: return "Not yet published"
        case .cancelled: return "Cancelled"
        case .unknow: return "Unknow"
        }
    }
    
    public init(from string: String) {
        let string = string.lowercased()
        let serieStatus = SerieStatus.allCases.first {
            $0.anime.lowercased() == string ||
            $0.manga.lowercased() == string
        }
        self = serieStatus ?? .unknow
    }
}

public enum SerieSort {
    case ascending(Criteria)
    case descending(Criteria)
    
    public enum Criteria: String {
        case id, score, popularity, start_date, end_date
    }
    
    public var criteria: String {
        switch self {
        case .ascending(let criteria): return criteria.rawValue
        case .descending(let criteria): return criteria.rawValue + "-desc"
        }
    }
}

public struct BrowseParameters {
    /// year: 4 digit year e.g. "2014"
    public var year: String?
    /// season: winter || spring || summer || fall
    public var season: SerieSeason?
    /// type: anime || manga
    public var type: SerieType?
    /// status: finished || currently || notYet || cancelled
    public var status: SerieStatus?
    /// genres: e.g. "Action,Comedy" Returns series that have ALL the genres.
    public var genres: [Genre]?
    /// genres_exclude: e.g. "Drama" Excludes series that have ANY of the genres.
    public var genres_exclude: [Genre]?
    ///  ascending/descending sort: id || score || popularity || start_date || end_date
    public var sort: SerieSort?
    /// airing_data: "true" Includes anime airing data in small models
    public var airing_data: Bool?
    /// full_page: "true" Returns all available results. Ignores pages. Only available when status="Currently Airing" or season is included
    public var full_page: Bool?
    /// page: int
    public var page: Int?
    
    public init() {
        self.page = 1
    }
    
    mutating public func nextPage() -> BrowseParameters {
        guard let page = self.page else {
            self.page = 1
            return self
        }
        self.page = page + 1
        return self
    }
}

public enum ListStatus: String {
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
public enum ListScore {
    case _10(point: Int)
    case _100(point: Int)
    /// 1 : 1-29, 2 : 30-49, 3 : 50-69, 4 : 70-89, 5 : 90-100
    case _5(star: Int)
    /// :( : 1-30, :| : 31-60, :) : 61-100
    case _3(smile: String)
    case _10Decimal(point: Float)
    public var name: String {
        switch self {
        case ._10(_): return "Point (0-10 int)"
        case ._100(_): return "Point (0-100 int)"
        case ._5(_): return "(0-5 int)"
        case ._3(_): return "Smiles (\":(\",\":|\",\":)\" String)"
        case ._10Decimal(_): return "Point decimal (0.0 - 10.0 Float)"
        }
    }
}

public enum ListScoreOrder {
    case score, alphabetical
}
