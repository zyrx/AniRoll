//
//  WSCharacters.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
@objc public protocol WSCharactersDelegate: WSResponseProtocol {
    
}

/// WSCharacters - Characters Manager
/// @link http://anilist-api.readthedocs.io/en/latest/characters.html
@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class WSCharacters: WSBase {
    
    public var delegate: WSCharactersDelegate?
    
    /// Basic - Returns character model.
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#basic
    /// If you set `page` to `true` returns characters model with the following:
    ///     * Small model anime with small model character
    ///     * Small model anime staff
    ///     * Small model manga staff
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#basic
    public func getCharacter(id: Int, page: Bool = false) {
        let path = String(format: "character/%d", id) + (page ? "/page" : "")
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
    
    /// Favourite - Toggle favourite
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#favourite-post
    public func toggleFavourite(id: Int) {
        let path = "character/favourite"
        let parameters: Parameters = ["id": id]
        self.manager.request(self.host + path, method: .post, parameters: parameters, headers: self.headers)
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
    
    /// Search - Returns small character models.
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#search
    public func search(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "character/search/%@", query)
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
