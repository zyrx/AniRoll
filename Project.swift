import ProjectDescription


// MARK: - Project
private let projectName = "AniRoll"

private let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
    "UIApplicationSupportsMultipleScenes": false,
    "UIApplicationSceneManifest": [
        "UISceneConfigurations": [
            "UIWindowSceneSessionRoleApplication": [[
                "UISceneConfigurationName": "Default Configuration",
                "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
            ]]
        ]
    ]
]

private let mainTarget = Target.target(
    name: projectName,
    destinations: .iOS,
    product: .app,
    bundleId: "net.mavels.\(projectName)",
    deploymentTargets: .iOS("15.0"),
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Targets/\(projectName)/Sources/**"],
    resources: ["Targets/\(projectName)/Resources/**"],
    dependencies: [
        .external(name: "Alamofire"),
        .external(name: "AlamofireImage"),
        .external(name: "SwiftyJSON"),
        .external(name: "SnapKit"),
        .external(name: "Realm"),
        .external(name: "RealmSwift"),
        .project(target: "AniList", path: "Projects/AniList")
    ]
)

private let testTarget = Target.target(
    name: "\(projectName)Tests",
    destinations: .iOS,
    product: .unitTests,
    bundleId: "net.mavels.\(projectName)Tests",
    deploymentTargets: .iOS("15.0"),
    infoPlist: .default,
    sources: ["Targets/\(projectName)/Tests/**"],
    dependencies: [
        .target(name: "\(projectName)")
])

let project =  Project(
    name: projectName,
    organizationName: "mavels.net",
    targets: [
        mainTarget,
        testTarget
    ]
)
