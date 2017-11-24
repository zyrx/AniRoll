//
//  WSUser.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/15/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSUserDelegate: WSResponseProtocol {
    @objc optional func wsUserDelegate(user: User?)
    @objc optional func wsUserDelegate(users: [User])
    @objc optional func wsUserDelegate(authorizationCode: String?)
}

/// User - Series Manager
/// @link http://anilist-api.readthedocs.io/en/latest/user.html
class WSUser: WSBase {
    
    var delegate: WSUserDelegate?
    
    /// Basic - Returns a user model.
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#basic
    func getUser(id: String) {
        let path = String(format: "user/%@", id)
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
            self.delegate?.wsUserDelegate?(user: User(json))
        }
    }
    
    /// Activity - Returns the activity of the user and activity messages from of other users.
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#activity
    func getUserActivity(id: Int? = nil, page: Int? = nil) {
        let id = id ?? 0
        let path = id > 0 ? String(format: "user/%@/activity", id) : "user/activity"
        let parameters: Parameters = [
            "page": page ?? 0
        ]
        self.manager.request(self.host + path, method: .get, parameters: parameters, headers: self.headers)
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
            self.delegate?.wsUserDelegate?(authorizationCode: json.string)
        }
    }
    
    enum Activity {
        case status(text: String)
        case message(text: String, messenger: Int)
        case reply(text: String, reply: Int)
        case removeReplay(id: Int)
        case remove(activity: Int)
        case follow(user: Int)
    }
    
    /// Update activity:
    ///    * Creates activity status, activity message and activity reply.
    ///    * Removes activity and activity reply.
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#create-activity-post
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#remove-activity-delete
    func setActivity(type activity: Activity) {
        var path = "user/activity"
        var method: HTTPMethod = .post
        var parameters: Parameters? = nil
        switch activity {
        case .status(let text):
            parameters = ["text": text]
        case .message(let text, let messenger):
            parameters = [
                "text": text,
                "messenger_id": messenger
            ]
        case .reply(let text, let reply):
            parameters = [
                "text": text,
                "reply_id": reply
            ]
        case .removeReplay(let id):
            path = "user/activity/reply"
            method = .delete
            parameters = ["id": id]
        case .remove(let activity):
            method = .delete
            parameters = ["id": activity]
        case .follow(let user):
            path = "user/follow"
            parameters = ["id": user]
        }
        self.manager.request(self.host + path, method: method, parameters: parameters, headers: self.headers)
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
    
    /// Notifications - Returns up to 10 notifications of the current user.
    ///                 If you set `count` to `true` returns int of current outstanding
    ///                 notifications of current user.
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#notifications
    func userNotifications(count: Bool = false) {
        let path = "user/notifications" + (count ? "/count" : "")
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
    
    /// Followers & Following
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#followers-following
    func followList(type followList: FollowList, id: Int) {
        let path = String(format: "user/%d/%@", id, followList.rawValue)
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
    enum FollowList: String {
        case following, followers
    }
    
    /// Follow/Unfollow - Toggle follow
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#follow-unfollow-post
    func toggleFollow(id: Int) {
        let path = "user/follow"
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
    
    /// Favourites - Returns a user’s favourites.
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#favourites
    func favourites(user id: Int) {
        let path = String(format: "user/%d/favourites", id)
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
    
    /// Airing - Returns anime list entry with small model anime, where the anime is
    ///          currently airing and being currently watched by the user.
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#airing
    func airing(limit: Int? = nil) {
        let path = "user/airing"
        let parameters: Parameters = ["id": limit ?? 0]
        self.manager.request(self.host + path, method: .get, parameters: parameters, headers: self.headers)
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
    
    /// Search - Returns small user models.
    /// @link http://anilist-api.readthedocs.io/en/latest/user.html#search
    func search(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "user/search/%@", query)
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
            self.delegate?.wsUserDelegate?(users: users)
        }
    }
}
