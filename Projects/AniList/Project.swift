//
//  Project.swift
//  AniRollManifests
//
//  Created by Lech H. Conde on 10/12/23.
//

import ProjectDescription

private let projectName = "AniList"

private let mainTarget = Target.target(
    name: projectName,
    destinations: .iOS,
    product: .framework,
    bundleId: "net.mavels.\(projectName)",
    deploymentTargets: .iOS("15.0"),
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

private let testTarget = Target.target(
    name: "\(projectName)Tests",
    destinations: .iOS,
    product: .unitTests,
    bundleId: "net.mavels.\(projectName)Tests",
    deploymentTargets: .iOS("15.0"),
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
