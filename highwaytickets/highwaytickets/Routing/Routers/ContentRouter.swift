//
//  ContentRouter.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import SwiftUI

class ContentRouter: BaseRouter {
                  
    @ViewBuilder
    func initialView() -> some View {
        ScreenFactory.createScreen(ForAppRouteDestination: .dashboard(parameters: .init(), router: self)).navigationDestination(for: AppRoute.self) {
            item in item.view
        }
    }

}

//MARK: - DashboardScreenRouting

extension ContentRouter: DashboardScreenRouting {
    
    func onDashboardScreenRoutingAction(action: DashboardScreenRoutingAction) {
        Log.log(WithCategory: "ContentRouter", Message: "DashboardScreenRoutingAction: \(action)", Type: .info)

        switch action {
        case .yearlyCountyTickets(vehicleInformation: let vehicleInformation, vignette: let vignette):
            push(appRoute: .init(destination: .yearlyCountyTickets(parameters: .init(vehicleInformation: vehicleInformation, vignette: vignette), router: self)))
        case .checkout(vehicleInformation: let vehicleInformation, vignette: let vignette):
            push(appRoute: .init(destination: .checkout(parameters: .init(vehicleInformation: vehicleInformation, vignette: vignette, selectedCounties: []), router: self)))
        }
    }
    
}

//MARK: - YearlyCountyTicketsScreenRouting

extension ContentRouter: YearlyCountyTicketsScreenRouting {
    
    func onYearlyCountyTicketsScreenRoutingAction(action: YearlyCountyTicketsScreenRoutingAction) {
        Log.log(WithCategory: "ContentRouter", Message: "YearlyCountyTicketsScreenRoutingAction: \(action)", Type: .info)

        switch action {
        case .close:
            goBack()
        case .checkout(vehicleInformation: let vehicleInformation, vignette: let vignette, selectedCounties: let selectedCounties):
            push(appRoute: .init(destination: .checkout(parameters: .init(vehicleInformation: vehicleInformation, vignette: vignette, selectedCounties: selectedCounties), router: self)))
        }
    }
    
}

//MARK: - CheckoutScreenRouting

extension ContentRouter: CheckoutScreenRouting {
        
    func onCheckoutScreenRoutingAction(action: CheckoutScreenRoutingAction) {
        Log.log(WithCategory: "ContentRouter", Message: "CheckoutScreenRoutingAction: \(action)", Type: .info)
        
        switch action {
        case .close:
            goBack()
        case .successfullPurchase:
            AppState.shared.appPhase = .successfulPurchase
        }
    }
    
}
