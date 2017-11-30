//
//  SerieViewControllerInformation.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/29/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit

extension SerieViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableViewDataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serieInformation?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SerieDataCell", for: indexPath)
        guard let data = self.serieInformation?[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.value
        return cell
    }
    
    // MARK: - UITableViewDelegate    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Do stuff
    }
}
