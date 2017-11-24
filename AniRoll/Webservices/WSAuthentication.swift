//
//  WSAuthentication.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/15/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol WSAuthenticationDelegate: WSResponseProtocol {
    func wsAuthenticationDelegate(accessToken: AccessToken?)
}

/// Authentication: The AniList API implements OAuth 2 authentication.
/// Supporting grant types: client credentials, authorization code, and a twitter-like authorization pin.
/// @link http://anilist-api.readthedocs.io/en/latest/authentication.html
class WSAuthentication: WSBase {
    var delegate: WSAuthenticationDelegate?
    
    enum GrantType {
        case clientCredentials
        case autorizationCode(id: Int, redirect: String)
        case autorizationPin(id: Int)
        case refreshToken(token: String)
        
        var key: String {
            switch self {
            case .clientCredentials: return "client_secret"
            case .autorizationCode(_, _), .autorizationPin(_): return "code"
            case .refreshToken(_): return "refresh_token"
            }
        }
        var name: String {
            switch self {
            case .clientCredentials: return "client_credentials"
            case .autorizationCode(_, _): return "authorization_code"
            case .autorizationPin(_): return "authorization_pin"
            case .refreshToken(_): return "refresh_token"
            }
        }
        var response: String {
            switch self {
            case .clientCredentials: return ""
            case .autorizationCode(_, _): return "code"
            case .autorizationPin(_): return "pin"
            case .refreshToken(_): return ""
            }
        }
    }
    
    
    /// Grant: Authorization Code/Pin
    /// @link http://anilist-api.readthedocs.io/en/latest/authentication.html#grant-authorization-code
    /// @link http://anilist-api.readthedocs.io/en/latest/authentication.html#grant-authorization-pin
    private func getAuthorization(type grantType: GrantType, callback: @escaping (String?) -> Void) {
        let path = "auth/authorize"
        var parameters: Parameters = [
            "grant_type": grantType.name,
            "response_type": grantType.response
        ]
        switch grantType {
        case .autorizationCode(let id, let redirect):
            parameters["client_id"] = id
            parameters["redirect_uri"] = redirect
        case .autorizationPin(let id):
            parameters["client_id"] = id
        default:
            callback(nil)
            return
        }
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
            callback(json.string)
            // self.delegate?.wsAuthenticationDelegate(authorizationCode: json.string)
        }
    }
    
    /// Grant: Client Credentials
    /// @link http://anilist-api.readthedocs.io/en/latest/authentication.html#grant-client-credentials
    func getAccess(using grantType: GrantType) {
        let path = "auth/access_token"
        var auth: String? = nil
        var parameters: Parameters = ["grant_type": grantType.name]
        switch grantType {
        case .clientCredentials:
            parameters["client_id"] = self.client
            parameters["client_secret"] = self.secret
        case .autorizationCode(_, _), .autorizationPin(_):
            self.getAuthorization(type: grantType) { authorization in
                auth = authorization
            }
        case .refreshToken(let token):
            print(token)
        }
        if let auth = auth {
            print(auth)
        }
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
            self.delegate?.wsAuthenticationDelegate(accessToken: AccessToken(json))
        }
    }
}
