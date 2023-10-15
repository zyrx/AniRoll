//
//  Media.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation

/// Media Types
/// @link http://anilist-api.readthedocs.io/en/latest/series.html#media-types
@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public enum Media: Int, CaseIterable {
    case tv
    case tvShort
    case movie
    case special
    case ova
    case ona
    case music
    case manga
    case novel
    case oneShot
    case doujin
    case manhua
    case manhwa
    
    public var name: String {
        switch self {
        case .tv: return "TV"
        case .tvShort: return "TV Short"
        case .movie: return "Movie"
        case .special: return "Special"
        case .ova: return "OVA"
        case .ona: return "ONA"
        case .music: return "Music"
        case .manga: return "Manga"
        case .novel: return "Novel"
        case .oneShot: return "One Shot"
        case .doujin: return "Doujin"
        case .manhua: return "Manhua"
        case .manhwa: return "Manhwa"
        }
    }
    
    public init?(from string: String) {
        guard let media = Media.allCases.first(where: {
            $0.name == string
        }) else { return nil }
        self = media
    }
}
