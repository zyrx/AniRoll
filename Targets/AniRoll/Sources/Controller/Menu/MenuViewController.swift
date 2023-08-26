//
//  MenuViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/22/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController, WSSeriesDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let wsSeries = WSSeries()

    var genres: Results<Genre>?
    var token: NotificationToken?
    
    let menuOptions: [(title: String, image: String)] = [
        ("Home", "icon-home"),
        ("Manga", "icon-manga"),
        ("Anime", "icon-anime"),
        ("Social", "icon-ar-group"),
        ("Forum", "icon-forum"),
        ("Public", "icon-public"),
        ("Reviews", "icon-review"),
        ("Favorite", "icon-favorite"),
        ("Settings", "icon-settings")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wsSeries.delegate = self
        do {
            let realm = try Realm(configuration: App.shared.realmConfiguration)
            let genres = realm.objects(Genre.self)
            self.genres = genres
            self.token = genres.observe { [weak self] (changes: RealmCollectionChange) in
                guard let tableView = self?.tableView else { return }
                switch changes {
                case .initial:
                    tableView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    tableView.beginUpdates()
                    tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 1) }), with: .automatic)
                    tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 1)}), with: .automatic)
                    tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 1) }), with: .automatic)
                    tableView.endUpdates()
                case .error(let error):
                    fatalError("\(error)")
                }
            }
            guard let genre = genres.first, Date().hours(from: genre.lastUpdate) < 24 else {
                self.wsSeries.genreList()
                return
            }
        } catch {
            print("Database error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.menuOptions.count
        case 1:
            return self.genres?.count ?? 0
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionCell")!
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = menuOptions[indexPath.row].title
            cell.imageView?.image = UIImage(named: menuOptions[indexPath.row].image)
        case 1:
            cell.textLabel?.text = self.genres?[indexPath.row].name
            cell.imageView?.image = nil
        default:
            break
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 1 ? "Genres" : nil
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "closeMenuViaNotification"), object: nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Do stuff
    }
    
    // MARK: - WSSeriesDelegate
    func wsSeriesDelegate(genres: [Genre]) {
        guard genres.count > 0 else { return }
        do {
            let realm = try Realm(configuration: App.shared.realmConfiguration)
            try realm.write {
                // @TODO: Remove genres first
                realm.add(genres)
            }
        } catch {
            print("Database error")
        }
    }
}
