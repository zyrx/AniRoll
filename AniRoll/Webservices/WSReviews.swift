//
//  WSReviews.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSReviewsDelegate: WSResponseProtocol {
    
}

/// WSReviews - Reviews Manager
/// @link http://anilist-api.readthedocs.io/en/latest/reviews.html
class WSReviews: WSBase {
    
    var delegate: WSReviewsDelegate?
    
    /// Review - Returns review model with small anime/manga and small user model.
    /// @link http://anilist-api.readthedocs.io/en/latest/reviews.html#review-get
    func getReview(type serieType: SerieType, id: Int) {
        let path = String(format: "%@/review/%d", serieType.name, id)
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
    
    /// Anime/Manga Reviews - Returns array of review models with anime/manga and small user model.
    /// @link http://anilist-api.readthedocs.io/en/latest/reviews.html#anime-manga-reviews-get
    func getReviewList(type serieType: SerieType, id: Int) {
        let path = String(format: "%@/%d/reviews", serieType.name, id)
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
    
    /// User Reviews - Returns array of review models with anime/manga and small user model.
    /// @link http://anilist-api.readthedocs.io/en/latest/reviews.html#user-reviews-get
    func getUserReviews(user id: Int) {
        let path = String(format: "user/%d/reviews", id)
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
    
    /// Rate Review - Post a review to a given anime/manga.
    /// @link http://anilist-api.readthedocs.io/en/latest/reviews.html#rate-review-post
    func rateReview(type serieType: SerieType, id: Int, rating: RatingType) {
        let path = String(format: "%@/review/rate", serieType.name)
        let parameters: Parameters = [
            "id": id,
            "rating": rating.rawValue
        ]
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
    /// Valid rating types
    enum RatingType: Int {
        case noRating = 0, upRating, downRating
    }
    
    /// Create Review - Create/Edit anime/manga review.
    /// @link http://anilist-api.readthedocs.io/en/latest/reviews.html#review-create-post-edit-put
    func createReview(type serieType: SerieType, review: NewReview) {
        let path = String(format: "%@/review", serieType.name)
        let id = review.id ?? 0
        var parameters: Parameters = [
            "text": review.text,
            "summary": review.summary,
            "private": review.`private`.hashValue,
            "score": review.score
        ]
        parameters[(serieType == .anime ? "anime_id" : "manga_id")] = id
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
    
    /// Remove Review - Removes a given anime/manga review.
    /// @link http://anilist-api.readthedocs.io/en/latest/reviews.html#remove-review-delete
    func removeReview(type serieType: SerieType, id: Int) {
        let path = String(format: "%@/review", serieType.name)
        let parameters: Parameters = ["id": id]
        self.manager.request(self.host + path, method: .delete, parameters: parameters).responseJSON { response in
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
