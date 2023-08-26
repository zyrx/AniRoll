//
//  Thread.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class SerieThread: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var user_id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var sticky: String?
    @objc dynamic var locked: String?
    @objc dynamic var last_reply: String = ""
    @objc dynamic var last_reply_user: Int = 0
    @objc dynamic var deleted_at: String?
    @objc dynamic var created_at: String = ""
    @objc dynamic var reply_count: Int = 0
    @objc dynamic var view_count: Int = 0
    @objc dynamic var subscribed: Bool = false
    @objc dynamic var page_data: PageData?
    let tags = List<Tag> ()
    let tags_anime = List<TagSerie> ()
    let tags_manga = List<TagSerie> ()
    @objc dynamic var user: User?
    @objc dynamic var reply_user: User?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class PageData: Object {
    @objc dynamic var total_root: Int = 0
    @objc dynamic var per_page: Int = 0
    @objc dynamic var current_page: Int = 0
    @objc dynamic var last_page: Int = 0
    @objc dynamic var from: Int = 0
    @objc dynamic var to: Int = 0
}

struct NewThread {
    var title: String
    var body: String
    var tags: String
    var tags_anime: String
    var tags_manga: String
}

//{
//    "id": 1,
//    "user_id": 2,
//    "title": "[Spoilers] Anime! (Episode 1 Discussion)",
//    "body": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed quis posuere urna.",
//    "sticky": null,
//    "locked": null,
//    "last_reply": "2014-10-07 10:29:22",
//    "last_reply_user": 1,
//    "deleted_at": null,
//    "created_at": "2014-10-07 10:23:21",
//    "reply_count": 2,
//    "view_count": 61,
//    "subscribed": false,
//    "page_data": {
//        "total_root": 11,
//        "per_page": 10,
//        "current_page": 1,
//        "last_page": 2,
//        "from": 1,
//        "to": 10
//    },
//    "tags": [
//    {
//    "id": 3,
//    "name": "Light Novels"
//    }
//    ],
//    "tags_anime": [
//    {
//    "id": 30,
//    "thread_id": 1,
//    "tag_id": 30,
//    "anime": [
//    {
//    "id": 30,
//    "title_romaji": "Neon Genesis Evangelion",
//    "type": "TV",
//    "image_url_med": "http://anilist.co/img/dir/anime/med/30.jpg",
//    "image_url_sml": "http://anilist.co/img/dir/anime/sml/30.jpg",
//    "title_japanese": "新世紀エヴァンゲリオン",
//    "title_english": "Neon Genesis Evangelion",
//    "image_url_lge": "http://anilist.co/img/dir/anime/reg/30.jpg",
//    "airing_status": "finished airing",
//    "average_score": "82",
//    "total_episodes": 26,
//    "adult": false,
//    "relation_type": null,
//    "role": null
//    }
//    ]
//    }
//    ],
//    "tags_manga": [],
//    "user": {
//        "id": 1,
//        "display_name": "Josh",
//        "image_url_lge": "http://img.anilist.co/user/reg/1.png",
//        "image_url_med": "http://img.anilist.co/user/sml/1.png"
//    },
//    "reply_user": {
//        "id": 1,
//        "display_name": "Josh",
//        "image_url_lge": "http://img.anilist.co/user/reg/1.png",
//        "image_url_med": "http://img.anilist.co/user/sml/1.png"
//    }
//}

