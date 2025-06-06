//
//  AppRouteDestination.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation

enum AppRouteDestination {
    case loader(parameters: LoaderScreenParameters, router: LoaderScreenRouting)
    case dashboard(parameters: DashboardScreenParameters, router: DashboardScreenRouting)
    //case welcome(parameters: WelcomeScreenParameters, router: WelcomeScreenRouting)
}
