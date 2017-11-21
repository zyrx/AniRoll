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

@objc protocol WSCharactersDelegate: WSResponseProtocol {
    
}

/// WSCharacters - Characters Manager
/// @link http://anilist-api.readthedocs.io/en/latest/characters.html
class WSCharacters: WSBase {
    
    var delegate: WSCharactersDelegate?
    
    /// Basic - Returns character model.
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#basic
    /// If you set `page` to `true` returns characters model with the following:
    ///     * Small model anime with small model character
    ///     * Small model anime staff
    ///     * Small model manga staff
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#basic
    func getCharacter(id: Int, page: Bool = false) {
        let path = String(format: "character/%d", id) + (page ? "/page" : "")
        self.manager.request(self.host + path, method: .get, parameters: nil).responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value as? String else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(parseJSON: value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Favourite - Toggle favourite
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#favourite-post
    func toggleFavourite(id: Int) {
        let path = "character/favourite"
        let parameters: Parameters = ["id": id]
        self.manager.request(self.host + path, method: .post, parameters: parameters).responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value as? String else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(parseJSON: value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Search - Returns small character models.
    /// @link http://anilist-api.readthedocs.io/en/latest/characters.html#search
    func search(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "character/search/%@", query)
        self.manager.request(self.host + path, method: .get, parameters: nil).responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value as? String else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(parseJSON: value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
}
