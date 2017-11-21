//
//  WSUserLists.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/21/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSUserListsDelegate: WSResponseProtocol {
    @objc optional func wsUserDelegate(list: [Serie], type: SerieType)
    @objc optional func wsUserDelegate(removed: Bool, type: SerieType, id: Int)
}

/// User Lists
/// @link http://anilist-api.readthedocs.io/en/latest/lists.html#list-scores
class WSUserLists: WSBase {
    var delegate: WSUserListsDelegate?
    
    /// User Lists
    /// @link http://anilist-api.readthedocs.io/en/latest/lists.html#user-lists
    func getUserList(user id: Int, type serieType: SerieType, raw: Bool = false) {
        let path = String(format: "user/%d/%@", id, serieType.name) + (raw ? "/raw" : "")
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
            var list = [Serie]()
            for item in json.arrayValue {
                if let serie = Serie(item) {
                    list.append(serie)
                }
            }
            self.delegate?.wsUserDelegate?(list: list, type: serieType)
        }
    }
    
    /// User List - Create/Edit entry (Anime/Manga)
    /// @link http://anilist-api.readthedocs.io/en/latest/lists.html#manga-list-create-entry-post-edit-entry-put
    func setUserList(serie: NewSerie, id: Int? = nil) {
        let path = serie.type.name
        let id = serie.id ?? 0
        let parameters: Parameters? = [
                "id": id,
                "list_status": serie.list_status,
                "score": serie.score.name,
                "score_raw": serie.score_raw,
                "episodes_watched": serie.episodes_watched ?? 0,
                "rewatched": serie.rewatched ?? 0,
                "volumes_read": serie.volumes_read ?? 0,
                "chapters_read": serie.chapters_read ?? 0,
                "reread": serie.reread ?? 0,
                "notes": serie.notes,
                "advanced_rating_scores": serie.advanced_rating_scores,
                "custom_lists": serie.custom_lists,
                "hidden_default": serie.hidden_default
            ]
        self.manager.request(self.host + path, method: (id > 0 ? .put : .post), parameters: parameters).responseJSON { response in
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
    
    /// Remove entry - Removes Anime/Manga list
    /// @link http://anilist-api.readthedocs.io/en/latest/lists.html#remove-entry-delete
    func removeEntry(type serieType: SerieType, id: Int) {
        let path = String(format: "%@/%d", serieType.name, id)
        self.manager.request(self.host + path, method: .delete, parameters: nil).responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value as? String else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(parseJSON: value)
            self.delegate?.wsUserDelegate?(removed: json.boolValue, type: serieType, id: id)
        }
    }
}
