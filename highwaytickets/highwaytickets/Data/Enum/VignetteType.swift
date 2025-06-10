//
//  VignetteType.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 10..
//

import Foundation

enum VignetteType: Codable {
    case day
    case month
    case week
    case year
    
    enum CodingKeys: String, CodingKey {
        case day = "DAY"
        case month = "MONTH"
        case week = "WEEK"
        case year = "YEAR"
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "DAY":
            self = .day
        case "MONTH":
            self = .month
        case "WEEK":
            self = .week
        case "YEAR":
            self = .year
        default:
            return nil
        }
    }
}
