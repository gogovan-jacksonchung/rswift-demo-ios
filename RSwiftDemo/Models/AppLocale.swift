//
//  AppLocale.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 16/12/2019.
//  Copyright © 2019 Jackson Chung. All rights reserved.
//

import Foundation

enum AppLocale: String, CustomStringConvertible {
    case english = "en"
    case englishSingapore = "en-SG"
    case traditionalChineseHongKong = "zh-HK"
    case traditionalChineseTaiwan = "zh-Hant"
    
    var description: String {
        switch self {
        case .english:
            return "English"
        case .englishSingapore:
            return "English (SG)"
        case .traditionalChineseHongKong:
            return "繁體中文（香港）"
        case .traditionalChineseTaiwan:
            return "繁體中文"
        }
    }
    
    var localeString: String {
        return self.rawValue
    }
}
