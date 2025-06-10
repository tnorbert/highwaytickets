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
    case yearlyCountyTickets(parameters: YearlyCountyTicketsScreenParameters, router: YearlyCountyTicketsScreenRouting)
    case checkout(parameters: CheckoutScreenParameters, router: CheckoutScreenRouting)
    case successfulPurchase(parameters: SuccessfulPurchaseScreenParameters, router: SuccessfulPurchaseScreenRouting)
}
