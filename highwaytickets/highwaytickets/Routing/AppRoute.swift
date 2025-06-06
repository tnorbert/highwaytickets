//
//  AppRoute.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import SwiftUI

struct AppRoute: CustomDebugStringConvertible {
    
    let id: UUID = .init()
    let destination: AppRouteDestination
    let view: AnyView
    
    var debugDescription: String {
        return "id: \(id), destination: \(destination)"
    }
    
    init(destination: AppRouteDestination) {
        self.destination = destination
        self.view = AnyView(ScreenFactory.createScreen(ForAppRouteDestination: destination))
    }
    
}

//MARK: - Hashable, Equatable

extension AppRoute: Hashable, Equatable {
    
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
