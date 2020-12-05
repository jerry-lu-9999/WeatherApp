//
//  Weathers.swift
//  CuteWeather
//
//  Created by Jiahao Lu on 12/3/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

struct Weathers: Codable{
//    enum CodingKeys: String, CodingKey{
//        case latitude, longitude, timezone, daily
//    }
    var latitude: Double
    var longitude: Double
    var timezone: String
    var daily: Daily
}

struct Daily: Codable {
    enum CodingKeys: String, CodingKey{
        case summary, icon, data
    }
    var summary: String
    var icon: String
    var data: [DailyWeather]
}

struct DailyWeather: Codable{
    var summary: String
    var time: Int
    var icon: String
    var sunriseTime: Int
    var sunsetTime: Int
    var temperatureHigh: Double
}

extension DailyWeather: Identifiable{
    var id: Int {time}
}

class model:Codable{
    var items = [DailyWeather]()
    var latitude = 0.0
    var longitude = 0.0
    var timezone : String
    var celcius = false
    init(items : [DailyWeather], latitude: Double, longtitude: Double, timezone: String) {
        self.items = items
        self.latitude = latitude
        self.longitude = longtitude
        self.timezone = timezone
    }
    
}
