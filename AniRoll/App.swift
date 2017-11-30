//
//  App.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/21/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import RealmSwift

class App: NSObject {
    static let shared = App()
    var realmConfiguration: Realm.Configuration!
    var accessToken: AccessToken?
    
    private override init() {
        super.init()
        self.realmConfiguration = self.getRealmConfiguration(for: .application, inMemory: true)
    }
    
    enum RealmType {
        case application
        case user(name: String)
    }
    
    func getRealmConfiguration(for type: RealmType, inMemory: Bool = false, setDefault: Bool = true)  -> Realm.Configuration {
        var identifier: String
        switch type {
        case .application:
            identifier = "AniRoll"
        case .user(let name):
            identifier = name
        }
        var config = Realm.Configuration()
        config.objectTypes = [
            //AccessToken.self
            StringObject.self,
            User.self,
            Serie.self,
            ScoreDistribution.self,
            ListStats.self,
            Genre.self,
            Airing.self
        ]
        // Use the default directory, but replace the filename with the username
        if(inMemory) {
            config.inMemoryIdentifier = identifier
        } else {
            config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(identifier).realm")
        
        }
        if setDefault {
            Realm.Configuration.defaultConfiguration = config
        }
        return config
    }
}
