//
//  AnimeViewControllerSearchBar.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/28/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit

extension AnimeViewController: UISearchBarDelegate {
    // MARK: - UISearchBarDelegate
    // return NO to not become first responder
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    // called when text starts editing
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Clear results
    }
    // return NO to not resign first responder
    // public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {}
    // called when text ends editing
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // Start searching
    }
    // called when text changes (including clear)
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Start filtering
    }
    // called before text changes
    //public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {}
    // called when keyboard search button pressed
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    // called when bookmark button pressed
    //public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {}
    // called when cancel button pressed
    //public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {}
    // called when search results button pressed
    //public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {}
    //public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {}
}
