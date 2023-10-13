import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let dependencies: Dependencies = DependencyContainer()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        window.rootViewController = storyboard.instantiateViewController(withIdentifier: "LaunchScreen")
        window.makeKeyAndVisible()
        
        installDependenciesAndStart(in: window)

        return true
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
