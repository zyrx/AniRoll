//
//  SerieViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/28/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

/// Series - A series is either an anime or manga. {series_type} is either ‘anime’ or ‘manga’.
/// @link http://anilist-api.readthedocs.io/en/latest/series.html#series
class SerieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var serieInformation: [(title: String, value: String)]?
    
    /// image_url_sml || image_url_med || image_url_lge: String - Image url. 24x39* (Not available for manga) || 93x133* || Image url. 225x323*
    @IBOutlet weak var serieImageView: UIImageView!
    /// image_url_banner: String? - Image url. 1720x390*
    @IBOutlet weak var serieLandscapeImageView: UIImageView!
    /// series_type: String - Anime or Manga
    @IBOutlet weak var serieTypeLabel: UILabel!
    /// title_romaji: String -  i.e. "Kangoku Gakuen"
    @IBOutlet weak var titleRomajiLabel: UILabel!
    /// title_english: String - i.e. "Prison School". When no English title is available, the romaji title will fill this value.
    @IBOutlet weak var titleEnglishLabel: UILabel!
    /// title_japanese: String - When no Japanese title is available, the romaji title will fill this value.
    @IBOutlet weak var titleJapaneseLabel: UILabel!
    /// type: String - MediaType (TV, TV Short, Movie, Special, OVA, ONA, Music, Manga, Novel, One Shot, Doujin, Manhua, Manhwa)
    @IBOutlet weak var typeLabel: UILabel!
    /// start_date: String? - Deprecated.
    @IBOutlet weak var startDateLabel: UILabel!
    /// end_date: String? - Deprecated.
    @IBOutlet weak var endDateLabel: UILabel!
    /// start_date_fuzzy: Int? - Fuzzy date (8 digit long integer representing YYYYMMDD)
    @IBOutlet weak var startDateFuzzyLabel: UILabel!
    /// end_date_fuzzy: Int? - Fuzzy date (8 digit long integer representing YYYYMMDD)
    @IBOutlet weak var endDateFuzzyLabel: UILabel!
    /// season: Int? - i.e. "164" First 2 numbers are the year (16 is 2016). Last number is the season starting at 1 (3 is Summer).
    @IBOutlet weak var seasonLabel: UILabel!
    /// description: String? - Description of series.
    @IBOutlet weak var descriptionLabel: UILabel!
    /// synonyms: [String] - Alternative titles, i.e. [“The Prison School”]
    @IBOutlet weak var synonymsLabel: UILabel!
    /// genres: [String] - List of genres
    @IBOutlet weak var genresLabel: UILabel!
    /// adult: Bool - True for adult series (Hentai). This does not include ecchi.
    @IBOutlet weak var adultLabel: UILabel!
    /// average_score: Double - 0-100, i.e. 67.8
    @IBOutlet weak var averageScoreLabel: UILabel!
    /// popularity: Int - Number of users with series on their list. i.e. 15340
    @IBOutlet weak var popularityLabel: UILabel!
    /// favourite: Bool - True if the current authenticated user has favorited the series. False if not authenticated.
    @IBOutlet weak var favouriteLabel: UILabel!
    /// updated_at: Int(Unix timestamp) - Last time the series data was modified. i.e. 1470913937
    @IBOutlet weak var updatedAtLabel: UILabel!
    /// score_distribution: [] - 0 - 100 distribution object
    @IBOutlet weak var scoreDistributionLabel: UILabel!
    /// list_stats: [] - List Stats. i.e. {"completed": 326, "on_hold": 2071, "dropped": 2158, "plan_to_watch": 446, "watching": 5758 }
    @IBOutlet weak var listStatsLabel: UILabel!
    
    // Anime model only values
    /// total_episodes: Int - Number of episodes in series season (0 if unknown).
    @IBOutlet weak var totalEpisodesLabel: UILabel!
    /// duration: Int? - Minutes in the average anime episode.
    @IBOutlet weak var durationLabel: UILabel!
    /// airing_status: String? - Current airing status of the anime: "finished airing" || "currently airing" || "not yet aired" || "cancelled"
    @IBOutlet weak var airingStatusLabel: UILabel!
    /// youtube_id: String? - Youtube video id. i.e. JIKFtTMvNSg
    @IBOutlet weak var youtubeIdLabel: UILabel!
    /// hashtag: String? Offical series twitter hashtag. i.e. #shingeki
    @IBOutlet weak var hashtagLabel: UILabel!
    /// source: String? - The source adaption media type: "Original" || "Manga" || "Light Novel" || "Visual Novel" || "Video Game" || "Other"
    @IBOutlet weak var sourceLabel: UILabel!
    /// airing_stats: [String]
    @IBOutlet weak var airingStatsLabel: UILabel!
    
    // Manga model only values
    /// total_chapters: Int - Number of total chapters in the manga (0 if unknown).
    @IBOutlet weak var totalChaptersLabel: UILabel!
    /// total_volumes: Int - Number of total volumes in the manga (0 if unknown).
    @IBOutlet weak var totalVolumesLabel: UILabel!
    /// publishing_status: String? - Current publishing status of the manga: "finished publishing" || "publishing" || "not yet published" || "cancelled"
    @IBOutlet weak var publishingStatusLabel: UILabel!
    
    let realm = try! Realm(configuration: App.shared.realmConfiguration)
    var id: Int? {
        didSet {
            guard let id = self.id else { return }
            self.serie = realm.object(ofType: Serie.self, forPrimaryKey: id)
        }
    }
    var serie: Serie? {
        didSet {
            guard let serie = self.serie else { return }
            self.reloadSerieInformation(for: serie)
        }
    }
    
    private func reloadSerieInformation(for serie: Serie) {
        var serieInformation = [(String, String)]()
        serieInformation.append(("Serie Type:", serie.type.toString))
        serieInformation.append(("Title:", "\(serie.title_romaji) (\(serie.title_japanese))"))
        serieInformation.append(("Media Type:", serie.media_type))
        serieInformation.append(("Start Date:", serie.startDate))
        serieInformation.append(("End Date:", serie.endDate))
        serieInformation.append(("Season:", serie.seasonString))
        if let description = serie.desc {
            serieInformation.append(("Description:", description))
        }
        let synonyms = serie.synonyms.map({$0.value})
        if synonyms.count > 0 {
            serieInformation.append(("Synonyms:", synonyms.reduce(", ", +)))
        }
        let genres = serie.genres.map({$0.value})
        if genres.count > 0 {
            serieInformation.append(("Genres:", genres.reduce(", ", +)))
        }
        serieInformation.append(("Adult Content:", serie.adult ? "Yes" : "No"))
        // @TODO: Following lines
        // Use emoji for this
        serieInformation.append(("Average Score:", "\(serie.average_score)"))
        serieInformation.append(("Popularity:", serie.title_romaji))
        // Use emoji for this
        serieInformation.append(("Favorite:", serie.favourite ? "Yes" : "No"))
        // Move to view body
        serieInformation.append(("Updated At:", "\(serie.updated_at)"))
        /// score_distribution: [] - 0 - 100 distribution object
        if let score_distribution = serie.score_distribution {
            serieInformation.append(("Score Distribution:", score_distribution.toString))
        }
        if let list_stats = serie.list_stats {
            serieInformation.append(("List Stats:", list_stats.toString))
        }
        // Anime model only values
        if case .anime = serie.type {
            serieInformation.append(("Episodes:", "\(serie.total_episodes)"))
            serieInformation.append(("Duration:", "\(serie.duration) Minutes"))
            serieInformation.append(("Airing:", serie.serieStatus.anime))
            if let youtube_id = serie.youtube_id {
                // UIApplication.sharedApplication().openURL("youtube://youtube_id")
                serieInformation.append(("YouTube:", String(format: "https://youtu.be/%@", youtube_id)))
            }
            if let hashtag = serie.hashtag {
                serieInformation.append(("Twitter:", String(format: "https://twitter.com/search?q=%23%@", hashtag)))
            }
            if let source = serie.source {
                serieInformation.append(("Source:", source))
            }
            if let airing = serie.airing {
                serieInformation.append(("Airing Stats:", airing.toString))
            }
        }
        // Manga model only values
        if case .manga = serie.type {
            serieInformation.append(("Total Chapter:", "\(serie.total_chapters)"))
            serieInformation.append(("Total Volumes:", "\(serie.total_volumes)"))
            serieInformation.append(("Publishing Status:", serie.serieStatus.manga))
        }
        self.serieInformation = serieInformation
        //self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
