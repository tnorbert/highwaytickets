//
//  CheckoutScreenFactory.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

class CheckoutScreenFactory {
    
    @ViewBuilder
    static func createView(parameters: CheckoutScreenParameters, router: CheckoutScreenRouting) -> some View {
        CheckoutScreen(parameters: parameters,
                       routing: router,
                       buyVignettesUseCase: BuyVignettesUseCase(remoteProvider: ProviderFactory.networkServiceProvider()))
            .environmentObject(HapticManager.shared)
    }
    
}
