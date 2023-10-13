//
//  DependencyInstaller.swift
//  AniRoll
//
//  Created by Lech H. Conde on 10/11/23.
//  Copyright © 2023 mavels.net. All rights reserved.
//

import Foundation

// MARK: - DependencyInstaller

protocol DependencyInstaller {
    func install(in container: DependencyInstalling) async throws
}

// MARK: - DependencyInstalling

protocol DependencyInstalling {
    @discardableResult
    func dependency<T>(
        lifetime: Lifetime,
        factory: @escaping (Resolver) async throws -> T
    ) async throws -> DependencyInstalling
    
    @discardableResult
    func dependency<T>(
        lifetime: Lifetime,
        id: Identifying,
        factory: @escaping @Sendable (Resolver) async throws -> T
    ) async throws -> DependencyInstalling
}
