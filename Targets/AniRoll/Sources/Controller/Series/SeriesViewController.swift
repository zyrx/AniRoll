//
//  SeriesViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/28/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage

class SeriesViewController: UIViewController, WSSeriesDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var serieType: SerieType!
    let wsSeries = WSSeries()
    var series: Results<Serie>? {
        didSet { self.filteredSeries = self.series }
    }
    var filteredSeries: Results<Serie>? {
        didSet { self.collectionView.reloadData() }
    }
    var token: NotificationToken?
    
    var currentPage: Int = 1
    var browseParameters = BrowseParameters()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboardWhenTappedAround()
        self.wsSeries.delegate = self
        do {
            let realm = try Realm(configuration: App.shared.realmConfiguration)
            let series = realm.objects(Serie.self).filter("series_type == %@", serieType.name)
            self.series = series
            self.token = series.observe { [weak self] (changes: RealmCollectionChange) in
                guard let collectionView = self?.collectionView else { return }
                guard self?.filteredSeries == self?.series else {
                    collectionView.reloadData()
                    return
                }
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
                self.wsSeries.browse(type: self.serieType, parameters: self.browseParameters)
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
                realm.add(series)
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
            AlertController.alert(title: "Timeout error", message: "Taking too long to respond")
        default:
            let title = "Error \(error.code)"
            print("Server error: \(error.localizedDescription)")
            AlertController.alert(title: title, message: "Please contact the system administrator.")
        }
    }
    
    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filteredSeries?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SerieViewCell", for: indexPath) as! SerieCollectionViewCell
        guard let serie = self.filteredSeries?[indexPath.row] else {
            return cell
        }
        cell.serieTitleLabel.text = serie.title_romaji
        cell.serieDescriptionLabel.text = serie.desc
        if let url = URL(string: serie.image_url_lge) {
            let image = String(format: "serie_character_%d", Int.random(min: 1, max: 5))
            cell.serieImageView.af_setImage(withURL: url, placeholderImage: UIImage(named: image))
        }
        if serie == self.filteredSeries?.last {
            self.wsSeries.browse(type: self.serieType, parameters: self.browseParameters.nextPage())
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let serie = self.filteredSeries?[indexPath.row] else {
            return
        }
        self.performSegue(withIdentifier: "SerieDetail", sender: serie.id)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, identifier == "SerieDetail" else {
            return
        }
        guard let id = sender as? Int, let viewController = segue.destination as? SerieViewController else {
            return
        }
        viewController.id = id
    }
    
    override func dismissKeyboard() {
        super.dismissKeyboard()
        guard let text = self.searchBar.text, !text.isEmpty else {
            self.filteredSeries = self.series
            return
        }
    }
}

private extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    var sizeClass: (horizontal: UIUserInterfaceSizeClass, vertical: UIUserInterfaceSizeClass) {
        return (self.traitCollection.horizontalSizeClass, self.traitCollection.verticalSizeClass)
    }
}
