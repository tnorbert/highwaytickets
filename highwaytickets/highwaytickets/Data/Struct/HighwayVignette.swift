//
//  HighwayVignette.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 10..
//

import Foundation
import SwiftUI

struct HighwayVignette: Hashable {
    let type: HighwayVignetteType
    let price: Int
    
    var name: LocalizedStringKey {
        switch type {
        case .day:
            return "highwayVignette.type.day"
        case .week:
            return "highwayVignette.type.week"
        case .month:
            return "highwayVignette.type.month"
        case .year:
            return "highwayVignette.type.year"
        }
    }
}
