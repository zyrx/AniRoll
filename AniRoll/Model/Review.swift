//
//  Review.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class Review: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var date: String = ""
    @objc dynamic var rating: Int = 0
    @objc dynamic var rating_amount: Int = 0
    @objc dynamic var summary: String = ""
    @objc dynamic var `private`: Int = 0
    @objc dynamic var user_rating: Int = 0
    @objc dynamic var text: String = ""
    @objc dynamic var score: Int = 0
    @objc dynamic var anime: Anime?
    @objc dynamic var user: User?
}

struct NewReview {
    var id: Int?
    var text: String
    var summary: String
    var `private`: Bool
    var score: Int
}
