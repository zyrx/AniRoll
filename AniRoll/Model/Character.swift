//
//  Character.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

enum CharacterType: String {
    case character, staff, actors
}

class Character: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name_alt: String = ""
    @objc dynamic var name_first: String = ""
    @objc dynamic var name_last: String = ""
    @objc dynamic var name_japanese: String = ""
    @objc dynamic var image_url_lge: String = ""
    @objc dynamic var image_url_med: String = ""
    @objc dynamic var role: String?
}
