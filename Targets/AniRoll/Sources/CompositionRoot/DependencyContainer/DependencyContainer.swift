//
//  DependencyContainer.swift
//  AniRoll
//
//  Created by Lech H. Conde on 10/11/23.
//  Copyright © 2023 mavels.net. All rights reserved.
//

import Foundation

// MARK: - Dependencies

protocol Dependencies {
    func install(from installers: [DependencyInstaller]) async throws
    func rootController() async throws -> RootController
}

// MARK: - DependencyContainer

actor DependencyContainer: Dependencies, Resolver {
    
    private var dependencies: [ObjectIdentifier: Any] = [:]
    private var resolving: Set<ObjectIdentifier> = []
    
    func install(from installers: [DependencyInstaller]) async throws {
        try await withThrowingTaskGroup(of: Void.self) { taskGroup in
            for installer in installers {
                taskGroup.addTask { try await installer.install(in: self) }
                try await taskGroup.next()
            }
        }
    }
    
    func resolve<T>() async throws -> T {
        try await resolve(id: ObjectIdentifier(T.self))
    }
    
    func resolve<T>(id: Identifying) async throws -> T {
        try await resolve(id: ObjectIdentifier(id))
    }
    
    private func resolve<T>(id: ObjectIdentifier) async throws -> T {
        let dependencyType = String(describing: T.self)
        
        guard let dependency = dependencies[id] as? Dependency<T> else {
            throw DependencyError.unresolved(dependencyType)
        }
        
        guard !resolving.contains(dependency.id) else {
            throw DependencyError.circular(dependencyType)
        }
        
        resolving.insert(dependency.id)
        let object = try await dependency.resolver.resolve(self)
        resolving.remove(dependency.id)
        
        return object
    }
}

extension DependencyContainer: DependencyInstalling {
    
    func dependency<T>(
        lifetime: Lifetime,
        factory: @escaping (Resolver) async throws -> T
    ) async throws -> DependencyInstalling {
        try installDependency(
            id: ObjectIdentifier(T.self),
            lifetime: lifetime,
            factory: factory
        )
    }
    
    @discardableResult
    func dependency<T>(
        lifetime: Lifetime,
        id: Identifying,
        factory: @escaping (Resolver) async throws -> T
    ) async throws -> DependencyInstalling {
        try installDependency(
            id: ObjectIdentifier(id),
            lifetime: lifetime,
            factory: factory
        )
    }
    
    private func installDependency<T>(
        id: ObjectIdentifier,
        lifetime: Lifetime,
        factory: @escaping (Resolver) async throws -> T
    ) throws -> DependencyInstalling {
        guard dependencies[id] == nil else {
            let dependencyType = String(describing: T.self)
            throw DependencyError.alreadyRegistered(dependencyType)
        }
        
        let resolver: Resolving<T>
        switch lifetime {
        case .new:
            resolver = Resolving(resolve: factory)
            
        case .single:
            var instance: T?
            resolver = Resolving { resolver in
                if let object = instance {
                    return object
                } else {
                    let object = try await factory(resolver)
                    instance = object
                    return object
                }
            }
            
        case .weak:
            weak var instance: AnyObject?
            resolver = Resolving { resolver in
                if let object = instance as? T {
                    return object
                } else {
                    let object = try await factory(resolver)
                    instance = object as AnyObject
                    return object
                }
            }
        }
        
        dependencies[id] = Dependency(
            id: id,
            lifetime: lifetime,
            resolver: resolver
        )
        
        return self
    }
}

extension DependencyContainer {
    func rootController() async throws -> RootController {
        try await resolve()
    }
}
