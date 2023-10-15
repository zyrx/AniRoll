//
//  Project.swift
//  AniRollManifests
//
//  Created by Lech H. Conde on 10/12/23.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "AniList"

private let mainTarget = Target(
    name: projectName,
    platform: .iOS,
    product: .framework,
    bundleId: "net.mavels.\(projectName)",
    infoPlist: .default,
    sources: ["Sources/**"],
    resources: [],
    dependencies: [
        .external(name: "Alamofire"),
        .external(name: "AlamofireImage"),
        .external(name: "SwiftyJSON"),
        .external(name: "Realm"),
        .external(name: "RealmSwift")
    ]
)

private let testTarget = Target(
    name: "\(projectName)Tests",
    platform: .iOS,
    product: .unitTests,
    bundleId: "net.mavels.\(projectName)Tests",
    infoPlist: .default,
    sources: ["Tests/**"],
    dependencies: [
        .target(name: "\(projectName)")
])

let aniListApi =  Project(
    name: projectName,
    organizationName: "mavels.net",
    targets: [
        mainTarget,
        testTarget
    ]
)
