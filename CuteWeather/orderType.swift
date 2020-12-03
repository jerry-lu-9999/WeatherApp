//
//  orderType.swift
//  CuteWeather
//
//  Created by Jiahao Lu on 12/3/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

enum orderType: Int, CaseIterable{
    case  `default`, alphabetic
    
    func title() -> String{
        switch self {
        case .default:
            return NSLocalizedString("str_default", comment: "")
        case .alphabetic:
            return NSLocalizedString("str_alphabetic", comment: "")
        }
    }
}
