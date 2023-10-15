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

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class SerieThread: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var user_id: Int = 0
    @objc dynamic public var title: String = ""
    @objc dynamic public var body: String = ""
    @objc dynamic public var sticky: String?
    @objc dynamic public var locked: String?
    @objc dynamic public var last_reply: String = ""
    @objc dynamic public var last_reply_user: Int = 0
    @objc dynamic public var deleted_at: String?
    @objc dynamic public var created_at: String = ""
    @objc dynamic public var reply_count: Int = 0
    @objc dynamic public var view_count: Int = 0
    @objc dynamic public var subscribed: Bool = false
    @objc dynamic public var page_data: PageData?
    let tags = List<Tag> ()
    let tags_anime = List<TagSerie> ()
    let tags_manga = List<TagSerie> ()
    @objc dynamic public var user: User?
    @objc dynamic public var reply_user: User?
    
    override static public func primaryKey() -> String? {
        return "id"
    }
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class PageData: Object {
    @objc dynamic public var total_root: Int = 0
    @objc dynamic public var per_page: Int = 0
    @objc dynamic public var current_page: Int = 0
    @objc dynamic public var last_page: Int = 0
    @objc dynamic public var from: Int = 0
    @objc dynamic public var to: Int = 0
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public struct NewThread {
    public var title: String
    public var body: String
    public var tags: String
    public var tags_anime: String
    public var tags_manga: String
}
