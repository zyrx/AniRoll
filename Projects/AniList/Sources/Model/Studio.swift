//
//  Studio.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Studio: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var studio_name: String = ""
    @objc dynamic public var studio_wiki: String = ""
    @objc dynamic public var main_studio: String?
}
