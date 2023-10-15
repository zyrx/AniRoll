//
//  Staff.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Staff: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var dob: Int = 0
    @objc dynamic public var website: String = ""
    @objc dynamic public var info: String = ""
    @objc dynamic public var name_first: String = ""
    @objc dynamic public var name_last: String = ""
    @objc dynamic public var name_first_japanese: String = ""
    @objc dynamic public var name_last_japanese: String = ""
    @objc dynamic public var image_url_lge: String = ""
    @objc dynamic public var image_url_med: String = ""
    @objc dynamic public var language: String = ""
    @objc dynamic public var role: String?
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public enum StaffType: String {
    case staff, actor
}
