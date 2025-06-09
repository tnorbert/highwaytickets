//
//  CheckoutScreen.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

//MARK: - Routing

protocol CheckoutScreenRouting: AnyObject {
    func onCheckoutScreenRoutingAction(action: CheckoutScreenRoutingAction)
}

enum CheckoutScreenRoutingAction {
    case close
}

//MARK: - Parameters

struct CheckoutScreenParameters {
    let vehicleInformation: VehicleInformation
    let vignette: HighwayVignette
}

//MARK: - View

struct CheckoutScreen: View {
    
    let parameters: CheckoutScreenParameters
    let routing: CheckoutScreenRouting
    
    let buyVignettesUseCase: BuyVignettesUseCaseProtocol
    
    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Text("checkoutScreen.label.title")
                    Divider()
                    
                    HStack {
                        Text("checkoutScreen.label.plate")
                        Spacer()
                        Text(parameters.vehicleInformation.plate)
                    }
                    
                    CustomButton(style: .full) {
                        buyVignettes()
                    }
                }
            }
        }
    }
    
    private func buyVignettes() {
        Task {
            let result = await buyVignettesUseCase.execeute(vignettes: [parameters.vignette], vehicleInformation: parameters.vehicleInformation)
            
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
}

#Preview {
    CheckoutScreen(parameters: .init(vehicleInformation: .init(name: "", plate: "", vignetteType: "", type: ""), vignette: .init(type: .day, price: 1)), routing: PreviewRouter(), buyVignettesUseCase: BuyVignettesUseCase_preview())
}
