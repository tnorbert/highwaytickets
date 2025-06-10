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
    case successfullPurchase
}

//MARK: - Parameters

struct CheckoutScreenParameters {
    let vehicleInformation: VehicleInformation
    let vignette: HighwayVignette
    let selectedCounties: [County]
}

//MARK: - View

struct CheckoutScreen: View {
    
    let parameters: CheckoutScreenParameters
    let routing: CheckoutScreenRouting
    let buyVignettesUseCase: BuyVignettesUseCaseProtocol
    
    @State var price: Int = 0
    @State var errorMessage: String? = nil
    @State var isPurchasingInProgres: Bool = false

    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        Text("checkoutScreen.label.title")
                            .font(Font.Montserrat.variable(size: .h3, weight: .bold))
                            .foregroundStyle(.darkBlue700)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        Spacer()
                    }
                    
                    Divider()
                        .padding([.bottom])
                    
                    HStack {
                        Text("checkoutScreen.label.plate")
                            .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                            .foregroundStyle(.darkBlue700)
                        Spacer()
                        Text(parameters.vehicleInformation.plate)
                            .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                            .foregroundStyle(.darkBlue700)
                    }
                    
                    HStack {
                        Text("checkoutScreen.label.type")
                            .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                            .foregroundStyle(.darkBlue700)
                        Spacer()
                        Text(parameters.vignette.name)
                            .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                            .foregroundStyle(.darkBlue700)
                    }
                    
                    if !parameters.selectedCounties.isEmpty {
                        Divider()
                            .padding([.top, .bottom])
                        
                        ForEach(parameters.selectedCounties) { county in
                            HStack {
                                Text(county.localizedName)
                                    .font(Font.Montserrat.variable(size: .medium, weight: .bold))
                                    .foregroundStyle(.darkBlue700)
                                Spacer()
                                Text("\(parameters.vignette.price) Ft")
                                    .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                                    .foregroundStyle(.darkBlue700)
                            }
                            .padding([.bottom], 10)
                        }
                    }
                    
                    Divider()
                        .padding([.top, .bottom])
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("checkoutScreen.label.summaryPrice")
                                .font(Font.Montserrat.variable(size: .medium, weight: .bold))
                                .foregroundStyle(.darkBlue700)
                            Text("\(price) Ft")
                                .font(Font.Montserrat.variable(size: .h2, weight: .bold))
                                .foregroundStyle(.darkBlue700)
                        }
                        
                        Spacer()
                    }
                    .padding([.bottom])
                    
                    CustomButton(style: .full, title: "checkoutScreen.button.buy", isFullWidth: true) {
                        buyVignettes()
                    }
                    
                    CustomButton(style: .hollow, title: "checkoutScreen.button.cancel", isFullWidth: true) {
                        routing.onCheckoutScreenRoutingAction(action: .close)
                    }
                }
                .padding(20)
            }
            
            if isPurchasingInProgres {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
                            .scaleEffect(2)
                        Spacer()
                    }
                    
                    Spacer()
                }
                .ignoresSafeArea()
                .background {
                    Color.gray.opacity(0.3)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationTitle("checkoutScreen.navigationTitle")
        .navigationBarBackButtonHidden(isPurchasingInProgres)
        .task {
            if parameters.vignette.type != .year {
                price = parameters.vignette.price
            } else {
                price = parameters.vignette.price * parameters.selectedCounties.count
            }
        }
        
    }
    
    private func buyVignettes() {
        guard !isPurchasingInProgres else { return }
        
        isPurchasingInProgres = true
        
        Task {
            let result = await buyVignettesUseCase.execeute(vignettes: [parameters.vignette], vehicleInformation: parameters.vehicleInformation)
            
            isPurchasingInProgres = false
            
            switch result {
            case .success(_):
                routing.onCheckoutScreenRoutingAction(action: .successfullPurchase)
            case .failure(let failure):
                break
            }
        }
    }
    
}

#Preview {
    CheckoutScreen(parameters: .init(vehicleInformation: .init(name: "", plate: "", vignetteType: "", type: ""), vignette: .init(type: .day, price: 1), selectedCounties: []), routing: PreviewRouter(), buyVignettesUseCase: BuyVignettesUseCase_preview())
}
