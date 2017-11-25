//
//  AnimeViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/21/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage

class AnimeViewController: UIViewController, WSSeriesDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let serieType: SerieType = .anime
    let wsSeries = WSSeries()
    var series: Results<Serie>?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wsSeries.delegate = self
        do {
            let realm = try Realm(configuration: App.shared.realmConfiguration)
            let series = realm.objects(Serie.self).filter("series_type == %@", serieType.name)
            self.series = series
            self.token = series.observe { [weak self] (changes: RealmCollectionChange) in
                guard let collectionView = self?.collectionView else { return }
                switch changes {
                case .initial:
                    collectionView.reloadData()
                case .update(_, let deletions, let insertions, let modifications):
                    collectionView.performBatchUpdates({
                        collectionView.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                        collectionView.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                        collectionView.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                    }, completion: nil)
                case .error(let error):
                    fatalError("\(error)")
                }
            }
            guard let serie = series.first, Date().hours(from: serie.lastUpdate) < 24 else {
                self.wsSeries.browse(type: self.serieType)
                return
            }
        } catch {
            print("Database error")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let accessToken = App.shared.accessToken, accessToken.expirationDate > Date() else {
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }

    // MARK: - WSSeriesDelegate
    func wsSeriesDelegate(series: [Serie], type: SerieType) {
        guard series.count > 0 else { return }
        do {
            let realm = try Realm(configuration: App.shared.realmConfiguration)
            try realm.write {
                realm.add(series, update: true)
            }
        } catch {
            print("Database error")
        }
    }
    
    func onResponseError(error: NSError) {
        LoadingActivity.hide()
        if let message = error.userInfo["message"] as? String {
            AlertController.alert(title: "", message: message)
            return
        }
        switch error.code {
        case NSURLErrorCancelled, NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost: break
        case NSURLErrorTimedOut, NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
            AlertController.alert(title: "Se agotó el tiempo de espera", message: "El servidor tardó demasiado en responder")
        default:
            let title = "Error (\(error.code)) en el servidor"
            print("Server error: \(error.localizedDescription)")
            AlertController.alert(title: title, message: "Favor de contactar al Administrador.")
        }
    }
    
    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.series?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerieViewCell", for: indexPath) as! SerieCollectionViewCell
        cell.serieTitleLabel.text = self.series?[indexPath.row].title_romaji
        cell.serieDescriptionLabel.text = self.series?[indexPath.row].desc
        if let url = URL(string: self.series?[indexPath.row].image_url_lge ?? "") {
            cell.serieImageView.af_setImage(withURL: url)
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Do stuff
    }
}
