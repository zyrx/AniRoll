//
//  Dependency.swift
//  AniRoll
//
//  Created by Lech H. Conde on 10/11/23.
//  Copyright © 2023 mavels.net. All rights reserved.
//

import Foundation

// MARK: - Dependency

struct Dependency<T>: Identifiable {
    let id: ObjectIdentifier
    let lifetime: Lifetime
    let resolver: Resolving<T>
    
    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Lifetime

enum Lifetime {
    case single
    case new
    case weak
}
