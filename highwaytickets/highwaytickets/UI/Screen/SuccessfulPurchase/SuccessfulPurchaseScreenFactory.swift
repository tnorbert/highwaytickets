//
//  SuccessfulPurchaseScreenFactory.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

class SuccessfulPurchaseScreenFactory {
    
    @ViewBuilder
    static func createView(parameters: SuccessfulPurchaseScreenParameters, router: SuccessfulPurchaseScreenRouting) -> some View {
        SuccessfulPurchaseScreen(parameters: parameters,
                       routing: router)
            .environmentObject(HapticManager.shared)
    }
    
}
