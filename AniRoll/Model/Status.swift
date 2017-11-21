//
//  Status.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation

enum AnimeStatus: String {
    case finishedAiring = "finished airing"
    case currentlyAiring = "currently airing"
    case notYetAired = "not yet aired"
    case cancelled = "cancelled"
}

enum MangaStatus: String {
    case finishedPublishing = "finished publishing"
    case publishing = "publishing"
    case notYetPublished = "not yet published"
    case cancelled = "cancelled"
}
