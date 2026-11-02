import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let dependencies: Dependencies = DependencyContainer()

    func configure(_ window: UIWindow) {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        window.rootViewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
        window.makeKeyAndVisible()

        installDependenciesAndStart(in: window)
    }

    private func installDependenciesAndStart(in window: UIWindow) {
        Task {
            do {
                try await dependencies.install(from: [
                    AppDependencyInstaller()
                ])
                window.rootViewController = try await dependencies.rootController()
                window.makeKeyAndVisible()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
