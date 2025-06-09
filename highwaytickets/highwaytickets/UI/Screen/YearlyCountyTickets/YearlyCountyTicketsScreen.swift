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
}

//MARK: - Parameters

struct YearlyCountyTicketsScreenParameters { }

//MARK: - View

struct YearlyCountyTicketsScreen: View {
    
    let parameters: YearlyCountyTicketsScreenParameters
    let routing: YearlyCountyTicketsScreenRouting
    
    @State private var isBacskiskunCheckboxChecked: Bool = false
    @State private var isBudapestCheckboxChecked: Bool = false
    @State private var isPestCheckboxChecked: Bool = false
    @State private var isBaranyaCheckboxChecked: Bool = false
    @State private var isBekesCheckboxChecked: Bool = false
    @State private var isBorsodabaujzemplenCheckboxChecked: Bool = false
    @State private var isCsongradcsanadCheckboxChecked: Bool = false
    @State private var isFejerCheckboxChecked: Bool = false
    @State private var isGyormosonsopronCheckboxChecked: Bool = false
    @State private var isHajdubiharCheckboxChecked: Bool = false
    @State private var isHevesCheckboxChecked: Bool = false
    @State private var isJasznagykunszolnokCheckboxChecked: Bool = false
    @State private var isKomaromesztergomCheckboxChecked: Bool = false
    @State private var isNogradCheckboxChecked: Bool = false
    @State private var isSomogyCheckboxChecked: Bool = false
    @State private var isSzabolcsszatmarberegCheckboxChecked: Bool = false
    @State private var isTolnaCheckboxChecked: Bool = false
    @State private var isVasCheckboxChecked: Bool = false
    @State private var isVeszpremCheckboxChecked: Bool = false
    @State private var isZalaCheckboxChecked: Bool = false

    @State var selectedCounties: Set<County> = []
    
    @State var price: Int = 0

    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
                        
            ScrollView {
                VStack {
                    Text("yearlyCountyTicketsScreen.label.title")
                        .font(Font.Montserrat.variable(size: .h3, weight: .bold))
                    
                    HungaryMap(selectedCounties: $selectedCounties)
                    
                    ForEach(County.allCases) { county in
                        CountyCheckboxRow(county: county, selectedCounties: $selectedCounties)
                    }
                    
                    Divider()
                    
                    Text("yearlyCountyTicketsScreen.label.summaryPrice")
                        .font(Font.Montserrat.variable(size: .medium, weight: .bold))
                    Text("\(price) Ft")
                        .font(Font.Montserrat.variable(size: .h2, weight: .bold))
                    
                    CustomButton(style: .full, title: "general.button.next", isFullWidth: true) {
                        
                    }
                }
                .padding(30)
                
            }
        }
        .onChange(of: selectedCounties) { oldValue, newValue in
            self.price = selectedCounties.count * 5450
            
            print("Good: \(checkSelectedCounties(selectedCounties: newValue.compactMap { $0 }))")
        }
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
            Spacer()
            Text("5 450 Ft")
                .font(Font.Montserrat.variable(size: .medium, weight: .bold))
        }
    }
    
}

#Preview {
    YearlyCountyTicketsScreen(parameters: .init(), routing: PreviewRouter())
}
