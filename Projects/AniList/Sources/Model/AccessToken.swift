//
//  AccessToken.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/23/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public struct AccessToken {
    public var access_token: String
    public var token_type: String
    public var expires: Int
    public var expires_in: Int
    public var refresh_token: String?
    public var expirationDate: Date {
        return Date(timeIntervalSince1970: Double(self.expires))
    }
    
    public init?(_ json: JSON) {
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
