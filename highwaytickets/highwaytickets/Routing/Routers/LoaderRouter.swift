//
//  LoaderRouter.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import SwiftUI

class LoaderRouter: BaseRouter {
                  
    @ViewBuilder
    func initialView() -> some View {
        ScreenFactory.createScreen(ForAppRouteDestination: .loader(parameters: .init(), router: self)).navigationDestination(for: AppRoute.self) {
            item in item.view
        }
    }

}

//MARK: - LoaderScreenRouting

extension LoaderRouter: LoaderScreenRouting {
    
    func onLoaderScreenRoutingAction(action: LoaderScreenRoutingAction) {
        Log.log(WithCategory: "LoaderRouter", Message: "LoaderScreenRoutingAction: \(action)", Type: .info)
        
        switch action {
        case .content:
            AppState.shared.appPhase = .content
        }
    }
    
}
