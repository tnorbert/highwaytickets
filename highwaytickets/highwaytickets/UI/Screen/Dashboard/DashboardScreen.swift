//
//  DashboardScreen.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import SwiftUI

//MARK: - Routing

protocol DashboardScreenRouting: AnyObject {
    func onDashboardScreenRoutingAction(action: DashboardScreenRoutingAction)
}

enum DashboardScreenRoutingAction {
    case yearlyCountyTickets
    case checkout(vehicleInformation: VehicleInformation, vignette: HighwayVignette)
}

//MARK: - Parameters

struct DashboardScreenParameters { }

//MARK: - View

struct DashboardScreen: View {
    
    let parameters: DashboardScreenParameters
    let routing: DashboardScreenRouting
    let getHighwayVignetteInformationUseCase: GetHighwayVignetteInformationUseCaseProtocol
    let vehicleInformationUseCase: GetVehicleInformationUseCaseProtocol
    
    @State var highwayVignetteInformation: HighwayVignetteInformation? = nil
    
    @State var selectedVignette: HighwayVignette? = nil
    @State var vehicleInformation: VehicleInformation? = nil
    
    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
            
            ScrollView {
                if let highwayVignetteInformation {
                    VStack {
                        VStack {
                            HStack {
                                Text("Országos matricák")
                                    .font(Font.Montserrat.variable(size: .h3, weight: .bold))
                                Spacer()
                            }
                            .padding()
                            
                            ForEach(highwayVignetteInformation.highwayVignettes, id: \.self) { vignette in
                                if selectedVignette == vignette {
                                    HStack {
                                        Text("\(vignette.name)")
                                        Spacer()
                                        Text("\(vignette.price) Ft")
                                    }
                                    .padding()
                                    .border(.black)
                                } else {
                                    HStack {
                                        Text("\(vignette.name)")
                                        Spacer()
                                        Text("\(vignette.price) Ft")
                                    }
                                    .padding()
                                    .contentShape(RoundedRectangle(cornerSize: .zero))
                                    .onTapGesture {
                                        selectedVignette = vignette
                                    }
                                }
                            }
                            
                            if let selectedVignette, let vehicleInformation {
                                CustomButton(style: .full, title: "dashboardScreen.button.buy", isFullWidth: true) {
                                    routing.onDashboardScreenRoutingAction(action: .checkout(vehicleInformation: vehicleInformation, vignette: selectedVignette))
                                    //routing.onDashboardScreenRoutingAction(action: .checkout(vignette: selectedVignette))
                                }
                            }
                            
                            
                        }
                        .background {
                            Color.white
                        }
                        .cornerRadius(24)
                        .padding([.leading, .trailing], 30)
                        
                        HStack {
                            Text("dashboardScreen.button.yearlyCountyTickets")
                                .font(Font.Montserrat.variable(size: .h3, weight: .bold))
                                .padding()
                            Spacer()
                            Image(systemName: "chevron.right")
                                .padding()
                        }
                        .contentShape(RoundedRectangle(cornerSize: .init(width: 24, height: 24)))
                        .background {
                            Color.white
                        }
                        .cornerRadius(24)
                        .padding([.leading, .trailing], 30)
                        .onTapGesture {
                            routing.onDashboardScreenRoutingAction(action: .yearlyCountyTickets)
                        }
                    }
                }
            }
        }
        .task {
            Task {
                await loadHighwayVignetteInformation()
                
                await loadVehicleInformation()
                
            }
        }
    }
    
    private func loadHighwayVignetteInformation() async {
        Task {
            let result = await getHighwayVignetteInformationUseCase.execute()
            
            switch result {
            case .success(let highwayInformation):
                self.highwayVignetteInformation = highwayInformation
            case .failure(let failure):
                break
            }
        }
    }
    
    private func loadVehicleInformation() async {
        Task {
            let result = await vehicleInformationUseCase.execute()
            
            switch result {
            case .success(let vehicleInformation):
                self.vehicleInformation = vehicleInformation
            case .failure(let failure):
                break
            }
        }
    }
    
}


#Preview {
    DashboardScreen(parameters: .init(), routing: PreviewRouter(), getHighwayVignetteInformationUseCase: GetHighwayVignetteInformationUseCase_preview(), vehicleInformationUseCase: GetVehicleInformationUseCase_preview())
}
