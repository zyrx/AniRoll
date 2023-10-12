//
//  Resolver.swift
//  AniRoll
//
//  Created by Lech H. Conde on 10/11/23.
//  Copyright © 2023 mavels.net. All rights reserved.
//

import Foundation

// MARK: - Resolver

protocol Resolver {
    func resolve<T>() async throws -> T
    func resolve<T>(id: Identifying) async throws -> T
}

struct Resolving<T> {
    let resolve: (Resolver) async throws -> T
}

// MARK: - Identifying

class Identifying: ExpressibleByStringLiteral {
    let identifier: String
    
    required init(stringLiteral value: String) {
        identifier = value
    }
}
