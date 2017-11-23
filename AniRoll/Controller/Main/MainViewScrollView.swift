//
//  MainViewScrollView.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/22/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit

extension MainViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.contentOffset.x: \(scrollView.contentOffset.x)")
        if scrollView.contentOffset.x < 0 {
            scrollView.contentOffset.x = 0
        } else if scrollView.contentOffset.x > self.slidingMenu.width {
            scrollView.contentOffset.x = self.slidingMenu.width
        }
        guard scrollView.contentOffset.x < (self.slidingMenu.width * 0.8) else {
            self.visualEffect.isHidden = true
            return
        }
        self.visualEffect.isHidden = false
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = true
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = false
    }
}
