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
    case yearlyCountyTickets(vehicleInformation: VehicleInformation, vignette: HighwayVignette)
    case checkout(vehicleInformation: VehicleInformation, vignette: HighwayVignette)
}

//MARK: - Parameters

struct DashboardScreenParameters { }

enum DashboardScreenState: Equatable {
    case initial
    case loaded
    case loading
    case error(errorMessage: String)
}

//MARK: - View

struct DashboardScreen: View {
    
    let parameters: DashboardScreenParameters
    let routing: DashboardScreenRouting
    let getHighwayVignetteInformationUseCase: GetHighwayVignetteInformationUseCaseProtocol
    let vehicleInformationUseCase: GetVehicleInformationUseCaseProtocol
    
    @State var dashboardState: DashboardScreenState = .initial
    @State var highwayVignetteInformation: HighwayVignetteInformation? = nil
    @State var selectedVignette: HighwayVignette? = nil
    @State var vehicleInformation: VehicleInformation? = nil
    @State var highwayVignettes: [HighwayVignette] = []
    @State var yearlyHighwayVignette: HighwayVignette? = nil
    
    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
            
            switch dashboardState {
            case .initial:
                VStack {
                    Spacer()
                }
            case .loading:
                VStack {
                    Text("dashboardScreen.label.loading")
                        .font(Font.Montserrat.variable(size: .h3, weight: .semibold))
                        .foregroundStyle(.darkBlue700)
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.darkBlue700)
                        .scaleEffect(2)
                        .padding()
                }
            case .loaded:
                ScrollView {
                    if let vehicleInformation {
                        VStack(spacing: 20) {
                            //Vehicle information
                            VehicleInformationView(vehicleInformation: vehicleInformation)
                                .padding([.leading, .trailing, .top], 20)
                            
                            VStack {
                                //Vignettes
                                HStack {
                                    Text("dashboardScreen.label.vignettes")
                                        .font(Font.Montserrat.variable(size: .h3, weight: .bold))
                                        .foregroundStyle(.darkBlue700)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                    Spacer()
                                }
                                .padding()
                                
                                ForEach(highwayVignettes, id: \.self) { vignette in
                                    HStack {
                                        HStack {
                                            Circle()
                                                .frame(width: 24, height: 24)
                                                .foregroundStyle(selectedVignette == vignette ? .darkBlue700 : .white)
                                                .overlay {
                                                    Circle()
                                                        .stroke(selectedVignette == vignette ? Color.darkBlue700 : Color.lightBlue700, lineWidth: 2)
                                                }
                                            
                                            Text(vignette.name)
                                                .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                                                .foregroundStyle(.darkBlue700)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.5)
                                            Spacer()
                                            Text("\(vignette.price) Ft")
                                                .font(Font.Montserrat.variable(size: .medium, weight: .bold))
                                                .foregroundStyle(.darkBlue700)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.5)
                                        }
                                        .padding()
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(selectedVignette == vignette ? Color.darkBlue700 : Color.lightBlue700, lineWidth: 2)
                                        )
                                    }
                                    .padding([.leading, .trailing])
                                    .contentShape(RoundedRectangle(cornerSize: .zero))
                                    .onTapGesture {
                                        selectedVignette = vignette
                                    }
                                }
                                
                                HStack {
                                    CustomButton(style: .full, title: "dashboardScreen.button.buy", isFullWidth: true) {
                                        if let selectedVignette {
                                            routing.onDashboardScreenRoutingAction(action: .checkout(vehicleInformation: vehicleInformation, vignette: selectedVignette))
                                        }
                                    }
                                    .disabled(selectedVignette == nil)
                                    .opacity(selectedVignette == nil ? 0.6 : 1.0)
                                    .padding()
                                }
                            }
                            .background {
                                Color.white
                            }
                            .cornerRadius(12)
                            .padding([.leading, .trailing], 20)
                            
                            //Yearly county tickets
                            if let yearlyHighwayVignette {
                                HStack {
                                    Text("dashboardScreen.button.yearlyCountyTickets")
                                        .font(Font.Montserrat.variable(size: .large, weight: .bold))
                                        .foregroundStyle(.darkBlue700)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .padding()
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .padding()
                                }
                                .contentShape(RoundedRectangle(cornerSize: .init(width: 24, height: 24)))
                                .background {
                                    Color.white
                                }
                                .cornerRadius(12)
                                .padding([.leading, .trailing], 20)
                                .onTapGesture {
                                    routing.onDashboardScreenRoutingAction(action: .yearlyCountyTickets(vehicleInformation: vehicleInformation, vignette: yearlyHighwayVignette))
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    Task {
                        await loadDashboard()
                    }
                }
            case .error(let errorMessage):
                VStack(spacing: 20, content: {
                    Text("dashboardScreen.label.error")
                        .font(Font.Montserrat.variable(size: .h3, weight: .semibold))
                        .foregroundStyle(.darkBlue700)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text(errorMessage)
                        .lineLimit(nil)
                        .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                        .foregroundStyle(.darkBlue700)
                    
                    CustomButton(style: .full, title: "general.button.retry") {
                        Task {
                            await loadDashboard()
                        }
                    }
                })
                .padding()
            }
        }
        .navigationTitle("dashboardScreen.navigationTitle")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            //Only load dashboard automatically at the first time
            if dashboardState == .initial {
                await loadDashboard()
            }
        }
    }
    
    private func loadDashboard() async {
        guard dashboardState != .loading else { return }
        
        dashboardState = .loading
        
        Task {
            let vehicleInformationResult = await vehicleInformationUseCase.execute()
            
            switch vehicleInformationResult {
            case .success(let vehicleInformation):
                let highwayVignetteInformationResult = await getHighwayVignetteInformationUseCase.execute()
                
                switch highwayVignetteInformationResult {
                case .success(let highwayInformation):
                    self.selectedVignette = nil
                    self.vehicleInformation = vehicleInformation
                    self.highwayVignetteInformation = highwayInformation
                    self.highwayVignettes = highwayInformation.highwayVignettes.filter({ vignetteToCheck in
                        return vignetteToCheck.type != .year
                    })
                    
                    self.yearlyHighwayVignette = highwayInformation.highwayVignettes.first(where: { vignetteToCheck in
                        return vignetteToCheck.type == .year
                    })
                    
                    dashboardState = .loaded
                case .failure(let failure):
                    dashboardState = .error(errorMessage: failure.localizedDescription)
                }
            case .failure(let failure):
                dashboardState = .error(errorMessage: failure.localizedDescription)
            }
        }
    }
    
}

//MARK: - VehicleInformationView

fileprivate struct VehicleInformationView: View {
    
    let vehicleInformation: VehicleInformation
    
    var body: some View {
        HStack {
            Image(systemName: "car")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(height: 24)
                .padding([.leading])
            
            VStack(alignment: .leading, content: {
                Text(vehicleInformation.plate)
                    .font(Font.Montserrat.variable(size: .large, weight: .bold))
                    .foregroundStyle(.darkBlue700)
                Text(vehicleInformation.name)
                    .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                    .foregroundStyle(.darkBlue700)
            })
            .padding([.top, .bottom])
            Spacer()
        }
        .background {
            Color.white
        }
        .cornerRadius(12)
    }
}

#Preview {
    DashboardScreen(parameters: .init(), routing: PreviewRouter(), getHighwayVignetteInformationUseCase: GetHighwayVignetteInformationUseCase_preview(), vehicleInformationUseCase: GetVehicleInformationUseCase_preview())
}
