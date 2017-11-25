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

extension Date {
    func years(from: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: from, to: self).year ?? -1
    }
    func months(from: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: from, to: self).month ?? -1
    }
    func weeks(from: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: from, to: self).weekOfYear ?? -1
    }
    func days(from: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: from, to: self).day ?? -1
    }
    func hours(from: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: from, to: self).hour ?? -1
    }
    func minutes(from: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: from, to: self).minute ?? -1
    }
    func seconds(from: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: from, to: self).second ?? -1
    }
    func offset(from: Date) -> String {
        if years(from: from) > 0 { return "\(years(from: from))y"   }
        if months(from: from)  > 0 { return "\(months(from: from))M"  }
        if weeks(from: from)   > 0 { return "\(weeks(from: from))w"   }
        if days(from: from)    > 0 { return "\(days(from: from))d"    }
        if hours(from: from)   > 0 { return "\(hours(from: from))h"   }
        if minutes(from: from) > 0 { return "\(minutes(from: from))m" }
        if seconds(from: from) > 0 { return "\(seconds(from: from))s" }
        return ""
    }
    func getDayOfYear() -> Int {
        return Calendar.current.ordinality(of: .day, in: .year, for: self) ?? -1
    }
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    func add(days: UInt) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = Int(days)
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    func add(hours: UInt) -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = Int(hours)
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    func add(minutes: UInt) -> Date {
        var dateComponents = DateComponents()
        dateComponents.minute = Int(minutes)
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    func add(seconds: UInt) -> Date {
        var dateComponents = DateComponents()
        dateComponents.second = Int(seconds)
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}
