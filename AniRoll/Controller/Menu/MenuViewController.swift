//
//  MenuViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/22/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
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

        self.view.layer.shadowColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuOptionCell")!
        cell.textLabel?.text = menuOptions[indexPath.row].title
        cell.imageView?.image = UIImage(named: menuOptions[indexPath.row].image)
        return cell
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
}
