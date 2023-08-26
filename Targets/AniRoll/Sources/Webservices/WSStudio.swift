//
//  WSStudio.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSStudioDelegate: WSResponseProtocol {
    
}

/// WSStudio - Studio Manager
/// @link http://anilist-api.readthedocs.io/en/latest/studio.html
class WSStudio: WSBase {
    
    var delegate: WSStudioDelegate?
    
    /// Basic - Returns a studio model.
    /// @link http://anilist-api.readthedocs.io/en/latest/studio.html#basic
    /// If you set `page` to `true` returns a studio model with small anime models.
    /// @link http://anilist-api.readthedocs.io/en/latest/studio.html#page
    func getStudio(id: Int, page: Bool = false) {
        let path = String(format: "studio/%d", id) + (page ? "/page" : "")
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard case .success(let value) = response.result else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "Server not responding"]))
                return
            }
            let json = JSON(value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Search - Returns studio models.
    /// @link http://anilist-api.readthedocs.io/en/latest/studio.html#search
    func search(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "studio/search/%@", query)
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard case .success(let value) = response.result else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "Server not responding"]))
                return
            }
            let json = JSON(value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
}
