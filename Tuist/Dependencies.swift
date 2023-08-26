import ProjectDescription

let dependencies = Dependencies(
    carthage: [
        .github(path: "Alamofire/Alamofire", requirement: .upToNext("5.7.0")),
        .github(path: "Alamofire/AlamofireImage", requirement: .upToNext("4.2.0")),
        .github(path: "SwiftyJSON/SwiftyJSON", requirement: .upToNext("5.0.0")),
        .github(path: "SnapKit/SnapKit", requirement: .upToNext("5.0.0")),
        .github(path: "realm/realm-swift", requirement: .upToNext("10.42.0"))
    ],
    platforms: [.iOS]
)
