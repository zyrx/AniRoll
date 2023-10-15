//
//  Anime.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Anime: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var title_romaji: String = ""
    @objc dynamic public var type: String = ""
    @objc dynamic public var image_url_med: String = ""
    @objc dynamic public var image_url_sml: String = ""
    @objc dynamic public var start_date: String = ""
    @objc dynamic public var end_date: String = ""
    @objc dynamic public var classification: String = ""
    @objc dynamic public var hashtag: String?
    @objc dynamic public var source: String?
    @objc dynamic public var title_japanese: String = ""
    @objc dynamic public var title_english: String = ""
    let synonyms = List<StringObject>()
    @objc dynamic public var desc: String = ""
    let genres = List<StringObject>()
    @objc dynamic public var image_url_lge: String = ""
    @objc dynamic public var image_url_banner: String = ""
    @objc dynamic public var duration: Int = 0
    @objc dynamic public var airing_status: String = ""
    @objc dynamic public var average_score: String = ""
    @objc dynamic public var total_episodes: Int = 0
    @objc dynamic public var youtube_id: String?
    @objc dynamic public var adult: Bool = false
    @objc dynamic public var popularity: Int = 0
    @objc dynamic public var relation_type: String?
    @objc dynamic public var role: String?
    @objc dynamic public var list_stats: ListStats?
    @objc dynamic public var airing: Airing?
}

public class Airing: Object {
    @objc dynamic public var time: String = ""
    @objc dynamic public var countdown: Int = 0
    @objc dynamic public var next_episode: Int = 0
    
    public var toString: String {
        return String(format:
            "Time: %@, Countdown: %d, Next episode: %d",
            self.time, self.countdown, self.next_episode
        )
    }
}

public enum AnimeSource: String {
    case original = "Original"
    case manga = "Manga"
    case lightNovel = "Light Novel"
    case visualNovel = "Visual Novel"
    case videoGame = "Video Game"
    case other = "Other"
}
