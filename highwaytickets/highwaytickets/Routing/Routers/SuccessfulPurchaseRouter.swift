//
//  SuccessfulPurchaseRouter.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import Foundation
import SwiftUI

class SuccessfulPurchaseRouter: BaseRouter {
                  
    @ViewBuilder
    func initialView() -> some View {
        ScreenFactory.createScreen(ForAppRouteDestination: .successfulPurchase(parameters: .init(), router: self)).navigationDestination(for: AppRoute.self) {
            item in item.view
        }
    }

}

//MARK: - DashboardScreenRouting

extension SuccessfulPurchaseRouter: SuccessfulPurchaseScreenRouting {
    
    func onSuccessfulPurchaseScreenRoutingAction(action: SuccessfulPurchaseScreenRoutingAction) {
        Log.log(WithCategory: "SuccessfulPurchaseRouter", Message: "SuccessfulPurchaseScreenRoutingAction: \(action)", Type: .info)
        
        switch action {
        case .close:
            AppState.shared.appPhase = .content
        }
    }
    
}
