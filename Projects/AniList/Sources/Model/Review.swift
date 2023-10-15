//
//  Review.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Review: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var date: String = ""
    @objc dynamic public var rating: Int = 0
    @objc dynamic public var rating_amount: Int = 0
    @objc dynamic public var summary: String = ""
    @objc dynamic public var `private`: Int = 0
    @objc dynamic public var user_rating: Int = 0
    @objc dynamic public var text: String = ""
    @objc dynamic public var score: Int = 0
    @objc dynamic public var anime: Anime?
    @objc dynamic public var user: User?
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public struct NewReview {
    public var id: Int?
    public var text: String
    public var summary: String
    public var `private`: Bool
    public var score: Int
}
