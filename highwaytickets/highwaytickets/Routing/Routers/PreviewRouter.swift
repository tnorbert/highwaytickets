//
//  PreviewRouter.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import SwiftUI

final class PreviewRouter: ObservableObject { }

extension PreviewRouter: LoaderScreenRouting {
    func onLoaderScreenRoutingAction(action: LoaderScreenRoutingAction) { }
}

extension PreviewRouter: DashboardScreenRouting {
    func onDashboardScreenRoutingAction(action: DashboardScreenRoutingAction) { }
}

extension PreviewRouter: YearlyCountyTicketsScreenRouting {
    func onYearlyCountyTicketsScreenRoutingAction(action: YearlyCountyTicketsScreenRoutingAction) { }
}

extension PreviewRouter: CheckoutScreenRouting {
    func onCheckoutScreenRoutingAction(action: CheckoutScreenRoutingAction) { }
}

extension PreviewRouter: SuccessfulPurchaseScreenRouting {
    func onSuccessfulPurchaseScreenRoutingAction(action: SuccessfulPurchaseScreenRoutingAction) { }
}
