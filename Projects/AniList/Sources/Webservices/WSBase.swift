//
//  WSBase.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/15/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
@objc public protocol WSResponseProtocol {
    @objc optional func onResponseError(error: NSError)
    @objc optional func onResponse(response: HTTPURLResponse?)
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
@objc public class WSBase: NSObject {
    public var manager = Session.default
    public var host: String = "https://anilist.co/api/"
    public let client: String = ""
    public let secret: String = ""
    public let redirect: String = "aniroll://"
    
    public var access_token: String { "" }
    
    public var headers: HTTPHeaders? {
        guard !self.access_token.isEmpty else {
            return nil
        }
        return [
        "Authorization": "Bearer \(access_token)",
        "Content-Type": "application/x-www-form-urlencoded"
        ]
    }

    override public init() {
        super.init()
    }
}

