//
//  WSBase.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/15/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol WSResponseProtocol {
    @objc optional func onResponseError(error: NSError)
    @objc optional func onResponse(response: HTTPURLResponse?)
}

@objc class WSBase: NSObject {
    var manager = Alamofire.SessionManager.default
    var host: String = "https://anilist.co/api/"
    let client: String = "zyrx-wtk52"
    let secret: String = "s6H7jYG1YovNzaK0e4ypUn"
    let redirect: String = "aniroll://"
    var access_token: String {
        guard let accessToken = App.shared.accessToken else {
            return ""
        }
        return accessToken.access_token
    }
    var headers: HTTPHeaders? {
        guard !self.access_token.isEmpty else {
            return nil
        }
        return [
        "Authorization": "Bearer \(access_token)",
        "Content-Type": "application/x-www-form-urlencoded"
        ]
    }

    override init() {
        super.init()
        // Setting ServerTrustPolicy
        if let host = URL(string: self.host)?.host {
            self.manager = SessionManager(serverTrustPolicyManager:
                ServerTrustPolicyManager(policies: [host: .disableEvaluation]))
            // @internal: Following lines enables ServerTrustPolicy.certificates (https)
            // let serverTrustPolicy: ServerTrustPolicy = .pinCertificates(
            //      certificates: ServerTrustPolicy.certificates(),
            //     validateCertificateChain: true, validateHost: true)
            //
            //self.manager = SessionManager(serverTrustPolicyManager:
            //ServerTrustPolicyManager(policies: [host: serverTrustPolicy]))
        }

    }
}

