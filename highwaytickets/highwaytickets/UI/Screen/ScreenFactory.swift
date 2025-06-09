//
//  ScreenFactory.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import SwiftUI

class ScreenFactory {
    
    @ViewBuilder
    static func createScreen(ForAppRouteDestination destination: AppRouteDestination) -> some View {
        switch destination {
        case .loader(parameters: let parameters, router: let router):
            LoaderScreenFactory.createView(parameters: parameters, router: router)
        case .dashboard(parameters: let parameters, router: let router):
            DashboardScreenFactory.createView(parameters: parameters, router: router)
        case .yearlyCountyTickets(parameters: let parameters, router: let router):
            YearlyCountyTicketsScreenFactory.createView(parameters: parameters, router: router)
        case .checkout(parameters: let parameters, router: let router):
            CheckoutScreenFactory.createView(parameters: parameters, router: router)
//        case .welcome(parameters: let parameters, router: let router):
//            let viewModel: WelcomeScreenViewModel = .init()
//            
//            WelcomeScreenFactory.createView(parameters: parameters, router: router, viewModel: viewModel)
//        case .login(parameters: let parameters, router: let router):
//            let viewModel: LoginScreenViewModel = .init()
//            
//            LoginScreenFactory.createView(parameters: parameters, router: router, viewModel: viewModel)
//        case .devmenu:
//            DevInchi.shared.debugViewSwiftUI()
        }
    }
    
}
