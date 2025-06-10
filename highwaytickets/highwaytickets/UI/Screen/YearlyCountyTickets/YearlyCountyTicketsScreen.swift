//
//  YearlyCountyTickets.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import SwiftUI

//MARK: - Routing

protocol YearlyCountyTicketsScreenRouting: AnyObject {
    func onYearlyCountyTicketsScreenRoutingAction(action: YearlyCountyTicketsScreenRoutingAction)
}

enum YearlyCountyTicketsScreenRoutingAction {
    case close
    case checkout(vehicleInformation: VehicleInformation, vignette: HighwayVignette, selectedCounties: [County])
}

//MARK: - Parameters

struct YearlyCountyTicketsScreenParameters {
    let vehicleInformation: VehicleInformation
    let vignette: HighwayVignette
}

//MARK: - View

struct YearlyCountyTicketsScreen: View {
    
    let parameters: YearlyCountyTicketsScreenParameters
    let routing: YearlyCountyTicketsScreenRouting

    @State var showBadSelectionAlert: Bool = false
    @State var selectedCounties: Set<County> = []
    @State var price: Int = 0

    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
                        
            ScrollView {
                VStack {
                    HStack {
                        Text("yearlyCountyTicketsScreen.label.title")
                            .font(Font.Montserrat.variable(size: .h3, weight: .bold))
                            .foregroundStyle(.darkBlue700)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        Spacer()
                    }
                    
                    HungaryMap(selectedCounties: $selectedCounties)
                        .padding([.top, .bottom])
                    
                    ForEach(County.allCases) { county in
                        CountyCheckboxRow(county: county, price: parameters.vignette.price, selectedCounties: $selectedCounties)
                            .padding([.bottom], 5)
                    }
                    
                    Divider()
                        .padding([.top, .bottom])
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("yearlyCountyTicketsScreen.label.summaryPrice")
                                .font(Font.Montserrat.variable(size: .medium, weight: .bold))
                                .lineLimit(1)
                                .foregroundStyle(.darkBlue700)
                            Text("\(price) Ft")
                                .font(Font.Montserrat.variable(size: .h1, weight: .bold))
                                .lineLimit(1)
                                .foregroundStyle(.darkBlue700)
                        }
                        Spacer()
                    }
                    
                    CustomButton(style: .full, title: "general.button.next", isFullWidth: true) {
                        if checkSelectedCounties(selectedCounties: selectedCounties.compactMap { $0 }) {
                            routing.onYearlyCountyTicketsScreenRoutingAction(action: .checkout(vehicleInformation: parameters.vehicleInformation, vignette: parameters.vignette, selectedCounties: selectedCounties.compactMap { $0 }))
                        } else {
                            showBadSelectionAlert = true
                        }
                    }
                    .disabled(selectedCounties.isEmpty)
                    .opacity(selectedCounties.isEmpty ? 0.6 : 1.0)
                }
                .padding(30)
            }
        }
        .navigationTitle("yearlyCountyTicketsScreen.navigationTitle")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: selectedCounties) { oldValue, newValue in
            self.price = selectedCounties.count * self.parameters.vignette.price
        }
        .alert("yearlyCountyTicketsScreen.alert.badSelection.title", isPresented: $showBadSelectionAlert, actions: {
            Button("yearlyCountyTicketsScreen.alert.badSelection.okButton") { }
        }, message: {
            Text("yearlyCountyTicketsScreen.alert.badSelection.message")
        })
    }
    
    private func checkSelectedCounties(selectedCounties: [County]) -> Bool {
        Log.log(WithCategory: "YearlyCountyTickets", Message: "Selected countis: \(selectedCounties)", Type: .debug)
                        
        guard let firstSelectedCountry = selectedCounties.first else {
            return false
        }
        
        var visitedCounties: Set<County> = []
        var stackOfCountriesToCheck: [County] = [firstSelectedCountry]
        
        while let currentCountryToCheck = stackOfCountriesToCheck.popLast() {
            if visitedCounties.contains(currentCountryToCheck) { continue }
            
            visitedCounties.insert(currentCountryToCheck)
            
            let validNeighbors = currentCountryToCheck.neighbours.filter { selectedCounties.contains($0) }
            stackOfCountriesToCheck.append(contentsOf: validNeighbors)
        }
        
        return visitedCounties.count == selectedCounties.count
    }
    
}

//MARK: - HungaryMap

fileprivate struct HungaryMap: View {
    
    @Binding var selectedCounties: Set<County>
    
    var body: some View {
        ZStack {
            ForEach(County.allCases) { county in
                Image(selectedCounties.contains(county) ? county.selectedImageName : county.imageName)
                    .resizable()
            }
        }
        .aspectRatio(313/188, contentMode: .fit)
    }
}

//MARK: - CountyCheckboxRow

fileprivate struct CountyCheckboxRow: View {
    
    let county: County
    let price: Int
    
    @Binding var selectedCounties: Set<County>
    
    var isChecked: Binding<Bool> {
        Binding<Bool> {
            selectedCounties.contains(county)
        } set: { newValue in
            if newValue {
                selectedCounties.insert(county)
            } else {
                selectedCounties.remove(county)
            }
        }
    }
    
    var body: some View {
        HStack {
            CustomCheckBox(isOn: isChecked)
            Text(county.localizedName)
                .font(Font.Montserrat.variable(size: .medium, weight: .regular))
                .foregroundStyle(.darkBlue700)
            Spacer()
            Text("\(price) Ft")
                .font(Font.Montserrat.variable(size: .medium, weight: .bold))
                .foregroundStyle(.darkBlue700)
        }
    }
    
}

#Preview {
    //YearlyCountyTicketsScreen(parameters: .init(vehicleInformation: .init(response: .in), vignette: .init()), routing: PreviewRouter())
}
