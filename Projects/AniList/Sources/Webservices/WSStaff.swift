//
//  WSStaff.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
@objc public protocol WSStaffDelegate: WSResponseProtocol {
    
}

/// WSStaff - Staff Manager
/// @link http://anilist-api.readthedocs.io/en/latest/staff.html
@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class WSStaff: WSBase {
    
    public var delegate: WSStaffDelegate?
    
    /// Basic - Returns staff model.
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#basic
    /// If you set `page` to `true` returns staff model with the following:
    ///     * Small model anime with small model actors
    ///     * Small model manga
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#page
    public func getStaff(type staffType: StaffType, id: Int, page: Bool = false) {
        var path = String(format: "%@/%d", staffType.rawValue, id)
        if case .staff = staffType, page {
            path = path + "/page"
        }
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
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#favourite-post
    public func toggleFavourite(type staffType: StaffType, id: Int) {
        let path = String(format: "%@/favourite", staffType.rawValue)
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
    
    /// Search - Returns small staff models.
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#search
    public func search(type staffType: StaffType, query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "%@/search/%@", staffType.rawValue, query)
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
