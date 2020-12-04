//
//  WeatherItem.swift
//  CuteWeather
//
//  Created by Jiahao Lu on 12/3/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

struct weatherItem: Codable{
    var latitude : Double
    var longitude : Double
    var temperature: Double
    var feelikeTemperature: Double
    
}
