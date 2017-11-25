//
//  WSSerie.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSSeriesDelegate: WSResponseProtocol {
    @objc optional func wsSeriesDelegate(genres: [Genre])
    @objc optional func wsSeriesDelegate(series: [Serie], type: SerieType)
}

/// WSSerie - Series Manager
/// A series is either an anime or manga. {series_type} is either ‘anime’ or ‘manga’.
/// @link http://anilist-api.readthedocs.io/en/latest/series.htm
class WSSeries: WSBase {
    
    var delegate: WSSeriesDelegate?
    
    /// Basic - Returns a series model.
    /// @link http://anilist-api.readthedocs.io/en/latest/series.html#basic
    func getSeries(type serieType: SerieType, user id: String) {
        let path = String(format: "%@/%@", serieType.name, id)
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Page - Returns a series model with the following:
    ///    * Up to 9 small model characters (ordered by main role) with Japanese small
    ///      model actors for anime
    ///    * Up to 9 small model staff
    ///    * Up to 2 small model reviews with their users
    ///    * Relations (small model)
    ///    * Anime/Manga relations (small model)
    ///    * Studios (anime)
    ///    * External links (anime)
    ///   @link http://anilist-api.readthedocs.io/en/latest/series.html#page
    func getPage(series: String, user id: String) {
        let path = String(format: "%@/%@/%@", series, id)
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Characters/Staff
    ///   - Returns series model with Small model characters (ordered by main role)
    ///     with small model actors. Small model staff.
    ///   @link http://anilist-api.readthedocs.io/en/latest/series.html#characters-staff
    func getCharacters(type characterType: CharacterType, series: String, user id: String) {
        let path = String(format: "%@/%@/%@", series, id, characterType.rawValue)
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Airing (anime only) - Returns key/value pair:
    ///    * Key: Episode number
    ///    * Value: Airing Time
    /// @link http://anilist-api.readthedocs.io/en/latest/series.html#airing-anime-only
    func airing(user id: String) {
        let path = String(format: "anime/%@/airing", id)
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Browse - Returns up to 40 small series models if paginating.
    /// @link http://anilist-api.readthedocs.io/en/latest/series.html#browse
    func browse(type serieType: SerieType) {
        let path = String(format: "browse/%@", serieType.name)
        /*
        let parameters: Parameters = [
            "year": "2014",
            "season": "winter", // SerieSeason
            "type": "anime",
            "status": "xxxxx",
            "genres": "Action,Comedy",
            "genres_exclude": "Drama",
            "sort": "id",
            "airing_data": "true",
            "full_page": "true",
            "page": 0
        ]
        */
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            var series = [Serie]()
            for item in json.arrayValue {
                if let serie = Serie(item) {
                    series.append(serie)
                }
            }
            self.delegate?.wsSeriesDelegate?(series: series, type: serieType)
        }
//        Url Parms:
//        year           : 4 digit year e.g. "2014"
//        season         : "winter" || "spring" || "summer" || "fall"
//        type           : (See types table above)
//        status         : (See status types table above)
//        genres         : Comma separated genre strings. e.g. "Action,Comedy" Returns series that have ALL the genres.
//        genres_exclude : Comma separated genre strings. e.g. "Drama" Excludes series that have ANY of the genres.
//        sort           : "id" || "score" || "popularity" || "start_date" || "end_date" Sorts results, default ascending order. Append "-desc" for descending order e.g. "id-desc"
//        airing_data    : "true" Includes anime airing data in small models
//        full_page      : "true" Returns all available results. Ignores pages. Only available when status="Currently Airing" or season is included
//        page           : int
    }
    
    /// Genre List - List of genres for use with browse queries
    /// @link http://anilist-api.readthedocs.io/en/latest/series.html#genre-list
    func genreList() {
        let path = "genre_list"
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            var genres = [Genre]()
            for item in json.arrayValue {
                if let genre = Genre(item) {
                    genres.append(genre)
                }
            }
            self.delegate?.wsSeriesDelegate?(genres: genres)
        }
    }
    
    /// Favourite - Toggle favourite
    /// @link http://anilist-api.readthedocs.io/en/latest/series.html#favourite-post
    func toggleFavourite(type serieType: SerieType, id: Int) {
        let path = String(format: "%@/favourite", serieType.name)
        let parameters: Parameters = ["id": id]
        self.manager.request(self.host + path, method: .post, parameters: parameters, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Search - Returns series models.
    /// @link http://anilist-api.readthedocs.io/en/latest/series.html#search
    func search(type serieType: SerieType, query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "%@/search/%@", serieType.name, query)
        self.manager.request(self.host + path, method: .get, parameters: nil, headers: self.headers)
            .responseJSON { response in
            if case .failure(let error as NSError) = response.result {
                self.delegate?.onResponseError?(error: error)
                return
            }
            guard let value = response.result.value else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "No hay respuesta del servidor"]))
                return
            }
            let json = JSON(value)
            var users = [User]()
            for item in json.arrayValue {
                if let user = User(item) {
                    users.append(user)
                }
            }
            // @TODO: Proper use of users
        }
    }
}
