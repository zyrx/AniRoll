//
//  Studio.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class Studio: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var studio_name: String = ""
    @objc dynamic var studio_wiki: String = ""
    @objc dynamic var main_studio: String?
}
