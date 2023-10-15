//
//  Comment.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Comment: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var parent_id: Int = 0
    @objc dynamic public var user_id: Int = 0
    @objc dynamic public var thread_id: Int = 0
    @objc dynamic public var comment: String = ""
    @objc dynamic public var created_at: String = ""
    @objc dynamic public var updated_at: String = ""
    @objc dynamic public var user: User?
    public let children = List<Comment> ()
    
    override static public func primaryKey() -> String? {
        return "id"
    }
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public struct NewComment {
    public var thread_id: Int
    public var comment: String
    public var reply_id: Int
}
