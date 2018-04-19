//
//  Extension.swift
//  Niksam
//
//  Created by Cyril PIVEC on 18/10/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    struct Formatter {
        
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            return formatter
        }()
        
    }
    
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
    func timeAgoSinceDate(numericDates: Bool) -> String {
        let calendar = Calendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < self ? now : self
        let latest = (earliest == now) ? self : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        guard let year = components.year,
        let month = components.month,
        let day = components.day,
        let weekOfYear = components.weekOfYear,
        let hour = components.hour,
        let minute = components.minute,
        let second = components.second else { return "" }
        if (year >= 2) {
            return "il y a \(year) ans"
        } else if (year >= 1) {
            if (numericDates) {
                return "il y a 1 an"
            } else {
                return "an dernier"
            }
        } else if (month >= 2) {
            return "il y a \(month) mois"
        } else if (month >= 1) {
            if (numericDates) {
                return "il y a 1 mois"
            } else {
                return "mois dernier"
            }
        } else if (weekOfYear >= 2) {
            return "il y a \(weekOfYear) semaines"
        } else if (weekOfYear >= 1){
            if (numericDates) {
                return "il y a 1 semaine"
            } else {
                return "semaine dernière"
            }
        } else if (day >= 2) {
            return "il y a \(day) jours"
        } else if (day >= 1){
            if (numericDates) {
                return "il y a 1 jour"
            } else {
                return "hier"
            }
        } else if (hour >= 2) {
            return "il y a \(hour) heures"
        } else if (hour >= 1){
            if (numericDates) {
                return "il y a 1 heure"
            } else {
                return "il y a une heure"
            }
        } else if (minute >= 2) {
            return "il y a \(minute) minutes"
        } else if (minute >= 1){
            if (numericDates) {
                return "il y a 1 minute"
            } else {
                return "il y a une minute"
            }
        } else if (second >= 3) {
            return "il y a \(second) seconds"
        } else {
            return "à l'instant"
        }
    }
}

extension String {
    
    var dateFromISO8601: Date? {
        return Date.Formatter.iso8601.date(from: self)
    }
    
}

extension UIImage {
  
}
