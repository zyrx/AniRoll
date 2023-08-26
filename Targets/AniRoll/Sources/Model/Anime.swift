//
//  Anime.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class Anime: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title_romaji: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var image_url_med: String = ""
    @objc dynamic var image_url_sml: String = ""
    @objc dynamic var start_date: String = ""
    @objc dynamic var end_date: String = ""
    @objc dynamic var classification: String = ""
    @objc dynamic var hashtag: String?
    @objc dynamic var source: String?
    @objc dynamic var title_japanese: String = ""
    @objc dynamic var title_english: String = ""
    let synonyms = List<StringObject>()
    @objc dynamic var desc: String = ""
    let genres = List<StringObject>()
    @objc dynamic var image_url_lge: String = ""
    @objc dynamic var image_url_banner: String = ""
    @objc dynamic var duration: Int = 0
    @objc dynamic var airing_status: String = ""
    @objc dynamic var average_score: String = ""
    @objc dynamic var total_episodes: Int = 0
    @objc dynamic var youtube_id: String?
    @objc dynamic var adult: Bool = false
    @objc dynamic var popularity: Int = 0
    @objc dynamic var relation_type: String?
    @objc dynamic var role: String?
    @objc dynamic var list_stats: ListStats?
    @objc dynamic var airing: Airing?
}

class Airing: Object {
    @objc dynamic var time: String = ""
    @objc dynamic var countdown: Int = 0
    @objc dynamic var next_episode: Int = 0
    
    var toString: String {
        return String(format:
            "Time: %@, Countdown: %d, Next episode: %d",
            self.time, self.countdown, self.next_episode
        )
    }
}

enum AnimeSource: String {
    case original = "Original"
    case manga = "Manga"
    case lightNovel = "Light Novel"
    case visualNovel = "Visual Novel"
    case videoGame = "Video Game"
    case other = "Other"
}
