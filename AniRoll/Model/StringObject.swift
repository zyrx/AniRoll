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

class StringObject: Object {
    @objc dynamic var value: String = ""
    convenience init(_ value: String) {
        self.init()
        self.value = value
    }
}
