//
//  DashboardScreenFactory.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import SwiftUI

class DashboardScreenFactory {
    
    @ViewBuilder
    static func createView(parameters: DashboardScreenParameters, router: DashboardScreenRouting) -> some View {
        DashboardScreen(parameters: parameters, routing: router)
    }
    
}
