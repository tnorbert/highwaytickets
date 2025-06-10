//
//  HighwayVignetteInformation.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 10..
//

import Foundation

struct HighwayVignetteInformation {
    
    let highwayVignettes: [HighwayVignette]
    
    init(response: HighwayVignetteInformationResponse) {
        var highwayVignettes: [HighwayVignette] = []
        
        for vignette in response.payload.highwayVignettes {
            switch vignette.vignetteType {
            case .day:
                highwayVignettes.append(.init(type: .day, price: vignette.cost))
            case .week:
                highwayVignettes.append(.init(type: .week, price: vignette.cost))
            case .month:
                highwayVignettes.append(.init(type: .month, price: vignette.cost))
            case .year:
                highwayVignettes.append(.init(type: .year, price: vignette.cost))
            }
        }
        
        self.highwayVignettes = highwayVignettes
    }
    
}
