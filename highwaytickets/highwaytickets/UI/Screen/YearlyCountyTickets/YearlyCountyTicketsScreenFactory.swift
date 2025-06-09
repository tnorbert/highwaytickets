//
//  YearlyCountyTicketsScreenFactory.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

class YearlyCountyTicketsScreenFactory {
    
    @ViewBuilder
    static func createView(parameters: YearlyCountyTicketsScreenParameters, router: YearlyCountyTicketsScreenRouting) -> some View {
        YearlyCountyTicketsScreen(parameters: parameters, routing: router)
            .environmentObject(HapticManager.shared)
    }
    
}
