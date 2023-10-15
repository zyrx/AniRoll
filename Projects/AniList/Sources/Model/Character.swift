//
//  Character.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public enum CharacterType: String {
    case character, staff, actors
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Character: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var name_alt: String = ""
    @objc dynamic public var name_first: String = ""
    @objc dynamic public var name_last: String = ""
    @objc dynamic public var name_japanese: String = ""
    @objc dynamic public var image_url_lge: String = ""
    @objc dynamic public var image_url_med: String = ""
    @objc dynamic public var role: String?
}
