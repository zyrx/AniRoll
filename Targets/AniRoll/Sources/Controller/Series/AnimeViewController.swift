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

class AnimeViewController: SeriesViewController {
    override func viewDidLoad() {
        self.serieType = .anime
        super.viewDidLoad()
    }
}
