//
//  Extensions.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/21/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get { return self.frame.origin.x }
        set { self.frame.origin.x = newValue }
    }
    var y: CGFloat {
        get { return self.frame.origin.y }
        set { self.frame.origin.y = newValue }
    }
    var height: CGFloat {
        get { return self.frame.size.height }
        set { self.frame.size.height = newValue }
    }
    var width: CGFloat {
        get { return self.frame.size.width }
        set { self.frame.size.width = newValue }
    }
}

public extension Int {
    /// Returns a random Int point number between 0 and Int.max
    public static var random: Int {
        return Int.random(n: Int.max)
    }
    /// Random integer between 0 and n-1
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    /// Random integer between min and max
    public static func random(min: Int, max: Int) -> Int {
        return Int.random(n: max - min + 1) + min
    }
}
