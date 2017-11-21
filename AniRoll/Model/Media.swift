//
//  Media.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/13/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation

enum Media: Int {
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
    
    var name: String {
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
}
