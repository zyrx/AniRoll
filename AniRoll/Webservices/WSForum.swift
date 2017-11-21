//
//  WSForum.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSForumDelegate: WSResponseProtocol {
    
}

/// WSForum - Forum Manager
/// @link http://anilist-api.readthedocs.io/en/latest/forum.html
class WSForum: WSBase {
    
    var delegate: WSForumDelegate?
    
    enum PostType: String {
        case recent, new, suscribed
    }
    
    /// Recent - Returns threads ordered by most recent activity or creation.
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#recent
    func getPosts(type postType: PostType, page: Int = 0) {
        let path = String(format: "forum/%@", postType.rawValue)
        let parameters: Parameters = ["page": page]
        self.manager.request(self.host + path, method: .get, parameters: parameters).responseJSON { response in
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
    
    /// Tags - Returns threads which belong to all of the included tags,
    ///        ordered by most recent activity or creation.
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#tags
    func getPosts(tags: String, anime: String? = nil, manga: String? = nil, page: Int? = nil) {
        let path = "forum/tag"
        let parameters: Parameters = [
            "tags": tags,
            "anime": anime ?? "",
            "manga": manga ?? "",
            "page": page ?? 0
        ]
        self.manager.request(self.host + path, method: .get, parameters: parameters).responseJSON { response in
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
    
    /// Thread - Thread data
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#thread
    func getThread(id: Int) {
        let path = String(format: "forum/thread/%d", id)
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
    
    /// Post/Put thread
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#create-thread-post
    func postThread(thread: NewThread, id: Int? = nil) {
        let path = "forum/thread"
        let id = id ?? 0
        let parameters: Parameters = [
            "id": id,
            "title": thread.title,
            "body": thread.body,
            "tags": thread.tags,
            "tags_anime": thread.tags_anime,
            "tags_manga": thread.tags_manga
        ]
        self.manager.request(self.host + path, method: id > 0 ? .put : .post, parameters: parameters).responseJSON { response in
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
    
    /// Remove thread
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#remove-thread-delete
    func removeThread(id: Int) {
        let path = String(format: "forum/thread/%d", id)
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
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Thread subscribe - Toggle thread subscribe
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#thread-subscribe-post
    func toggleSubscription(id: Int) {
        let path = String(format: "forum/thread/%d", id)
        let parameters: Parameters = ["thread_id": id,]
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
    
    /// Create comment
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#create-comment-post
    func postComment(comment: NewComment, id: Int? = nil) {
        let path = "forum/comment"
        let id = id ?? 0
        let parameters: Parameters = [
            "thread_id": comment.thread_id,
            "comment": comment.comment,
            "reply_id": comment.reply_id
        ]
        self.manager.request(self.host + path, method: id > 0 ? .put : .post, parameters: parameters).responseJSON { response in
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
    
    /// Remove comment
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#remove-comment-delete
    func removeComment(id: Int) {
        let path = String(format: "forum/thread/%d", id)
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
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Search - Returns search feed threads.
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#search
    func search(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "forum/search/%@", query)
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

