//
//  WSForum.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
@objc public protocol WSForumDelegate: WSResponseProtocol {
    
}

/// WSForum - Forum Manager
/// @link http://anilist-api.readthedocs.io/en/latest/forum.html
@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class WSForum: WSBase {
    
    public var delegate: WSForumDelegate?
    
    public enum PostType: String {
        case recent, new, suscribed
    }
    
    /// Recent - Returns threads ordered by most recent activity or creation.
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#recent
    public func getPosts(type postType: PostType, page: Int = 0) {
        let path = String(format: "forum/%@", postType.rawValue)
        let parameters: Parameters = ["page": page]
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
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Tags - Returns threads which belong to all of the included tags,
    ///        ordered by most recent activity or creation.
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#tags
    public func getPosts(tags: String, anime: String? = nil, manga: String? = nil, page: Int? = nil) {
        let path = "forum/tag"
        let parameters: Parameters = [
            "tags": tags,
            "anime": anime ?? "",
            "manga": manga ?? "",
            "page": page ?? 0
        ]
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
            // @TODO: Proper use of value
            print(value)
            print(json.stringValue)
        }
    }
    
    /// Thread - Thread data
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#thread
    public func getThread(id: Int) {
        let path = String(format: "forum/thread/%d", id)
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
    
    /// Post/Put thread
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#create-thread-post
    public func postThread(thread: NewThread, id: Int? = nil) {
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
        self.manager.request(self.host + path, method: id > 0 ? .put : .post, parameters: parameters, headers: self.headers)
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
    
    /// Remove thread
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#remove-thread-delete
    public func removeThread(id: Int) {
        let path = String(format: "forum/thread/%d", id)
        self.manager.request(self.host + path, method: .delete, parameters: nil, headers: self.headers)
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
    
    /// Thread subscribe - Toggle thread subscribe
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#thread-subscribe-post
    public func toggleSubscription(id: Int) {
        let path = String(format: "forum/thread/%d", id)
        let parameters: Parameters = ["thread_id": id,]
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
    
    /// Create comment
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#create-comment-post
    public func postComment(comment: NewComment, id: Int? = nil) {
        let path = "forum/comment"
        let id = id ?? 0
        let parameters: Parameters = [
            "thread_id": comment.thread_id,
            "comment": comment.comment,
            "reply_id": comment.reply_id
        ]
        self.manager.request(self.host + path, method: id > 0 ? .put : .post, parameters: parameters, headers: self.headers)
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
    
    /// Remove comment
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#remove-comment-delete
    public func removeComment(id: Int) {
        let path = String(format: "forum/thread/%d", id)
        self.manager.request(self.host + path, method: .delete, parameters: nil, headers: self.headers)
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
    
    /// Search - Returns search feed threads.
    /// @link http://anilist-api.readthedocs.io/en/latest/forum.html#search
    public func search(query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "forum/search/%@", query)
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

