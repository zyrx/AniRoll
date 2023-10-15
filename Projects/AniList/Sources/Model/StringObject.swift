//
//  StringObject.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class StringObject: Object {
    @objc dynamic public var value: String = ""
    
    convenience public init(_ value: String) {
        self.init()
        self.value = value
    }
}
