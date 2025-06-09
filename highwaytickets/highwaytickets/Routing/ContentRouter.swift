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
        case .yearlyCountyTickets:
            push(appRoute: .init(destination: .yearlyCountyTickets(parameters: .init(), router: self)))
        }
    }
    
}

//MARK: - YearlyCountyTicketsScreenRouting

extension ContentRouter: YearlyCountyTicketsScreenRouting {
    
    func onYearlyCountyTicketsScreenRoutingAction(action: YearlyCountyTicketsScreenRoutingAction) {
        Log.log(WithCategory: "ContentRouter", Message: "YearlyCountyTicketsScreenRoutingAction: \(action)", Type: .info)

        switch action {
        case .close:
            break
        }
    }
    
}
