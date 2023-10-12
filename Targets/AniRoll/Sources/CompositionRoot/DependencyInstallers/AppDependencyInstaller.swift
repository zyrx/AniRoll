//
//  AppDependencyInstaller.swift
//  AniRoll
//
//  Created by Lech H. Conde on 10/11/23.
//  Copyright © 2023 mavels.net. All rights reserved.
//

import Foundation
import UIKit

actor AppDependencyInstaller: DependencyInstaller {
    
    func install(in container: DependencyInstalling) async throws {
        try await container
            .dependency(lifetime: .new) { resolver in
                let configuration = URLSessionConfiguration.default
                configuration.timeoutIntervalForRequest = 120
                
                return URLSession(configuration: configuration)
            }
            .dependency(lifetime: .new) { _ in
                await LoginPage() as RootController
            }
    }
}
