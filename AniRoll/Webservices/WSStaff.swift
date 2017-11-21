//
//  WSStaff.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSStaffDelegate: WSResponseProtocol {
    
}

/// WSStaff - Staff Manager
/// @link http://anilist-api.readthedocs.io/en/latest/staff.html
class WSStaff: WSBase {
    
    var delegate: WSStaffDelegate?
    
    /// Basic - Returns staff model.
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#basic
    /// If you set `page` to `true` returns staff model with the following:
    ///     * Small model anime with small model actors
    ///     * Small model manga
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#page
    func getStaff(type staffType: StaffType, id: Int, page: Bool = false) {
        var path = String(format: "%@/%d", staffType.rawValue, id)
        if case .staff = staffType, page {
            path = path + "/page"
        }
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
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#favourite-post
    func toggleFavourite(type staffType: StaffType, id: Int) {
        let path = String(format: "%@/favourite", staffType.rawValue)
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
    
    /// Search - Returns small staff models.
    /// @link http://anilist-api.readthedocs.io/en/latest/staff.html#search
    func search(type staffType: StaffType, query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        let path = String(format: "%@/search/%@", staffType.rawValue, query)
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
