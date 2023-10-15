//
//  Tag.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/16/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import Foundation
import RealmSwift

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class Tag: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var name: String = ""
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public class TagSerie: Object {
    @objc dynamic public var id: Int = 0
    @objc dynamic public var thread_id: Int = 0
    @objc dynamic public var tag_id: Int = 0
    @objc dynamic public var serie: Serie?
}

@available(*, deprecated, message: "Anilist's v1 API was disabled on May 1st, 2018")
public enum TagType: Int {
    case anime = 1
    case manga
    case lightNovels
    case visualNovels
    case releaseDiscussion
    case unused
    case general
    case news
    case music
    case gaming
    case siteFeedback
    case bugReports
    case siteAnnouncements
    case listCustomisation
    case recommendations
    case forumGames
    case misc
    case aniListApps
    
    public var name: String {
        switch self {
        case .anime: return "Anime"
        case .manga: return "Manga"
        case .lightNovels: return "Light Novels"
        case .visualNovels: return "Visual Novels"
        case .releaseDiscussion: return "Release Discussion"
        case .unused: return "(Unused)"
        case .general: return "General"
        case .news: return "News"
        case .music: return "Music"
        case .gaming: return "Gaming"
        case .siteFeedback: return "Site Feedback"
        case .bugReports: return "Bug Reports"
        case .siteAnnouncements: return "Site Announcements"
        case .listCustomisation: return "List Customisation"
        case .recommendations: return "Recommendations"
        case .forumGames: return "Forum Games"
        case .misc: return "Misc"
        case .aniListApps: return "AniList Apps"
        }
    }
}
