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

    /// Browse - Returns up to 40 small series models if paginating.
    /// @link http://anilist-api.readthedocs.io/en/latest/series.html#browse
    func browse(type serieType: SerieType, parameters browseParameters: BrowseParameters? = nil) {
        let path = String(format: "browse/%@", serieType.name)
        var parameters: Parameters = Parameters()
        if let year = browseParameters?.year {
            parameters["year"] = year
        }
        if let season = browseParameters?.season {
            parameters["season"] = season.rawValue
        }
        if let type = browseParameters?.type {
            parameters["type"] = type.name
        }
        if let status = browseParameters?.status {
            parameters["status"] = status
        }
        if let genres = browseParameters?.genres {
            parameters["genres"] = genres.map({$0.name}).reduce(",", +)
        }
        if let genres_exclude = browseParameters?.genres_exclude {
            parameters["genres_exclude"] = genres_exclude.map({$0.name}).reduce(",", +)
        }
        if let sort = browseParameters?.sort {
            parameters["sort"] = sort
        }
        if let airing_data = browseParameters?.airing_data {
            parameters["airing_data"] = airing_data.description
        }
        if let full_page = browseParameters?.full_page {
            parameters["full_page"] = full_page ? "true" : "false"
        }
        if let page = browseParameters?.page {
            parameters["page"] = page
        }
        self.manager.request(self.host + path, method: .get, parameters: parameters, headers: self.headers)
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
            var series = [Serie]()
            for item in json.arrayValue {
                if let serie = Serie(item) {
                    series.append(serie)
                }
            }
            self.delegate?.wsSeriesDelegate?(series: series, type: serieType)
        }
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
            guard case .success(let value) = response.result else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "Server not responding"]))
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
            guard case .success(let value) = response.result else {
                self.delegate?.onResponseError?(error: NSError(domain: self.host, code: -1, userInfo: ["message": "Server not responding"]))
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
