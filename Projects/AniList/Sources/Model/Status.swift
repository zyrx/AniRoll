//
//  Status.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public enum AnimeStatus: String {
    case finishedAiring = "finished airing"
    case currentlyAiring = "currently airing"
    case notYetAired = "not yet aired"
    case cancelled = "cancelled"
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public enum MangaStatus: String {
    case finishedPublishing = "finished publishing"
    case publishing = "publishing"
    case notYetPublished = "not yet published"
    case cancelled = "cancelled"
}
