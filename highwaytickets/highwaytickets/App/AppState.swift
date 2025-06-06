//
//  AppState.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation

class AppState: ObservableObject, Equatable {
        
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        lhs.appPhase == rhs.appPhase
    }
    
    static let shared: AppState = AppState()
    
    @Published var appPhase: AppPhase
    
    private init() {
        appPhase = .loader
    }
    
}
