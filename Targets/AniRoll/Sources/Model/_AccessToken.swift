//
//  AccessToken.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/15/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class _AccessToken: Object {
    @objc dynamic var access_token: String = ""
    @objc dynamic var token_type: String = ""
    @objc dynamic var expires: Int = 0
    @objc dynamic var expires_in: Int = 0
    @objc dynamic var refresh_token: String?
    
    override static func primaryKey() -> String? {
        return "access_token"
    }
    
    convenience init?(_ json: JSON) {
        guard let access_token = json["access_token"].string else {
            return nil
        }
        self.init()
        self.access_token = access_token
        self.token_type = json["token_type"].stringValue
        self.expires = json["expires"].intValue
        self.expires_in = json["expires_in"].intValue
        self.refresh_token = json["refresh_token"].string
    }
}

