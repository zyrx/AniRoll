//
//  AccessToken.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/23/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import SwiftyJSON

struct AccessToken {
    var access_token: String
    var token_type: String
    var expires: Int
    var expires_in: Int
    var refresh_token: String?
    var expirationDate: Date {
        return Date(timeIntervalSince1970: Double(self.expires))
    }
    
    init?(_ json: JSON) {
        guard let access_token = json["access_token"].string else {
            return nil
        }
        self.access_token = access_token
        self.token_type = json["token_type"].stringValue
        self.expires = json["expires"].intValue
        self.expires_in = json["expires_in"].intValue
        self.refresh_token = json["refresh_token"].string
    }
}
