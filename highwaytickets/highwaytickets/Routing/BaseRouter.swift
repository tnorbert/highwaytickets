//
//  BaseRouter.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import SwiftUI

class BaseRouter: ObservableObject {
              
    @Published var path: NavigationPath = NavigationPath()

    init() {
        Log.log(WithCategory: "\(self)", Message: "Init", Type: .debug)
    }
    
    func goBack() {
        Log.log(WithCategory: "\(self)", Message: "Removing path component", Type: .info)
        
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func push(appRoute: AppRoute) {
        Log.log(WithCategory: "\(self)", Message: "Pushing route: \(appRoute)", Type: .info)

        path.append(appRoute)
    }
    
    func clearPath() {
        Log.log(WithCategory: "\(self)", Message: "Clearing path", Type: .info)

        path = NavigationPath()
    }

}
