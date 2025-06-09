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
}

//MARK: - Parameters

struct DashboardScreenParameters { }

//MARK: - View

struct DashboardScreen: View {
    
    let parameters: DashboardScreenParameters
    let routing: DashboardScreenRouting
    let getHighwayVignetteInformationUseCase: GetHighwayVignetteInformationUseCaseProtocol

    @State var highwayVignetteInformation: HighwayVignetteInformation? = nil
    
    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
                        
            ScrollView {
                if let highwayVignetteInformation {
                    VStack {
                        Text("Országos matricák")
                        
                        ForEach(highwayVignetteInformation.highwayVignettes, id: \.self) { vignette in
                            Text("\(vignette.name)")
                            //Text(type.rawValue)
                        }
                        
                    }
                }
                
                CustomButton(style: .full, title: "dashboardScreen.button.yearlyCountyTickets") {
                    //routing.onDashboardScreenRoutingAction(action: .yearlyCountyTickets)
                    
                    Task {
                        await loadHighwayVignetteInformation()

                    }
                }
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
    
}


#Preview {
    DashboardScreen(parameters: .init(), routing: PreviewRouter(), getHighwayVignetteInformationUseCase: GetHighwayVignetteInformationUseCase_preview())
}
