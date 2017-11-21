//
//  Staff.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class Staff: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var dob: Int = 0
    @objc dynamic var website: String = ""
    @objc dynamic var info: String = ""
    @objc dynamic var name_first: String = ""
    @objc dynamic var name_last: String = ""
    @objc dynamic var name_first_japanese: String = ""
    @objc dynamic var name_last_japanese: String = ""
    @objc dynamic var image_url_lge: String = ""
    @objc dynamic var image_url_med: String = ""
    @objc dynamic var language: String = ""
    @objc dynamic var role: String?
}

enum StaffType: String {
    case staff, actor
}
