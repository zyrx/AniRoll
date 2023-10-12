//
//  DependencyError.swift
//  AniRoll
//
//  Created by Lech H. Conde on 10/11/23.
//  Copyright © 2023 mavels.net. All rights reserved.
//

import Foundation

typealias DependencyType = String

// MARK: - DependencyContainer
enum DependencyError: LocalizedError {
    case unresolved(DependencyType)
    case circular(DependencyType)
    case alreadyRegistered(DependencyType)
    
    var errorDescription: String? {
        switch self {
        case .unresolved(let dependency):
            return "Unresolved Dependency: \(dependency)"
            
        case .circular(let dependency):
            return "Circular Dependency: \(dependency)"
            
        case .alreadyRegistered(let dependency):
            return "Already Registered: \(dependency)"
        }
    }
}
