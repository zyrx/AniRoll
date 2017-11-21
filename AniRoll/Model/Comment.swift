//
//  Comment.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

/// Comment Object
class Comment: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var parent_id: Int = 0
    @objc dynamic var user_id: Int = 0
    @objc dynamic var thread_id: Int = 0
    @objc dynamic var comment: String = ""
    @objc dynamic var created_at: String = ""
    @objc dynamic var updated_at: String = ""
    @objc dynamic var user: User?
    let children = List<Comment> ()
    override static func primaryKey() -> String? {
        return "id"
    }
}

struct NewComment {
    var thread_id: Int
    var comment: String
    var reply_id: Int
}

//"comments": [
//    {
//        "id": 139,
//        "parent_id": null,
//        "user_id": 1,
//        "thread_id": 61,
//        "comment": "root comment 1",
//        "created_at": "2014-10-20 09:31:57",
//        "updated_at": "2014-10-26 23:52:58",
//        "user": {
//            "id": 1,
//            "display_name": "Josh",
//            "image_url_lge": "http://img.anilist.co/user/reg/1.png",
//            "image_url_med": "http://img.anilist.co/user/sml/1.png"
//        },
//        "children": [
//        {
//        "id": 142,
//        "parent_id": 139,
//        "user_id": 1,
//        "thread_id": 61,
//        "comment": "child comment 1",
//        "created_at": "2014-10-26 23:52:39",
//        "updated_at": "2014-10-26 23:53:06",
//        "user": {
//        "id": 1,
//        "display_name": "Josh",
//        "image_url_lge": "http://img.anilist.co/user/reg/1.png",
//        "image_url_med": "http://img.anilist.co/user/sml/1.png"
//        },
//        "children": []
//        }
//        ]
//    },
//    {
//        "id": 143,
//        "parent_id": null,
//        "user_id": 1,
//        "thread_id": 61,
//        "comment": "root comment 2",
//        "created_at": "2014-10-26 23:52:53",
//        "updated_at": "2014-10-26 23:53:16",
//        "user": {
//            "id": 1,
//            "display_name": "Josh",
//            "image_url_lge": "http://img.anilist.co/user/reg/1.png",
//            "image_url_med": "http://img.anilist.co/user/sml/1.png"
//        },
//        "children": []
//    }
//]

