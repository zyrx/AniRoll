// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        productTypes: [
            "Alamofire": .framework,
            "AlamofireImage": .framework,
            "SwiftyJSON": .framework,
            "SnapKit": .framework
        ]
    )
#endif

let package = Package(
    name: "AniRollDependencies",
    platforms: [.iOS(.v15)],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.0"),
        .package(url: "https://github.com/Alamofire/AlamofireImage.git", from: "4.3.0"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.2"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1"),
        .package(url: "https://github.com/realm/realm-swift.git", from: "20.0.0")
    ]
)
