//
//  Utils.swift
//  CuteWeather
//
//  Created by Jiahao Lu on 12/4/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

public func readJSON<T: Decodable>(fileName: String, type: T.Type) -> T? {
    
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

public func dayFromSeconds(seconds: Int, timeZone: String?) -> String {
    
    let date = Date(timeIntervalSince1970: Double(seconds))
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    
    if let zoneString = timeZone {
        if TimeZone.knownTimeZoneIdentifiers.contains(zoneString) {
            formatter.timeZone = TimeZone(identifier: zoneString)
        } else {
            formatter.timeZone = TimeZone.autoupdatingCurrent
        }
    } else {
        formatter.timeZone = TimeZone.autoupdatingCurrent
    }
    
    var localTimeString = formatter.string(from: date)
    
    let todayTimeString = formatter.string(from: Date())
    if localTimeString == todayTimeString {
        return NSLocalizedString("str_today", comment: "")
    }
    
    let tomorrow = (Calendar.current as NSCalendar).date(byAdding: .day, value: 1, to: Date(), options:[])!
    let tomorrowTimeString = formatter.string(from: tomorrow)
    if localTimeString == tomorrowTimeString {
        return NSLocalizedString("str_tomorrow", comment: "")
    }
    
    formatter.dateFormat = "cccc"
    localTimeString = formatter.string(from: date)
    return localTimeString
}
