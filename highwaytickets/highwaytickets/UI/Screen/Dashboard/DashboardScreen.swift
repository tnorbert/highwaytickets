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
    case close
}

//MARK: - Parameters

struct DashboardScreenParameters { }

//MARK: - View

struct DashboardScreen: View {
    
    let parameters: DashboardScreenParameters
    let routing: DashboardScreenRouting
    
    @State var selectedCounties: Set<County> = []

    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
                        
            HungaryMap(selectedCounties: $selectedCounties)
                .border(.black)
                .onTapGesture {
                    if Bool.random() {
                        selectedCounties.insert(.bacskiskun)
                    } else {
                        selectedCounties.remove(.bacskiskun)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.budapest)
                    } else {
                        selectedCounties.remove(.budapest)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.pest)
                    } else {
                        selectedCounties.remove(.pest)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.baranya)
                    } else {
                        selectedCounties.remove(.baranya)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.bekes)
                    } else {
                        selectedCounties.remove(.bekes)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.borsodabaujzemplen)
                    } else {
                        selectedCounties.remove(.borsodabaujzemplen)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.csongradcsanad)
                    } else {
                        selectedCounties.remove(.csongradcsanad)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.fejer)
                    } else {
                        selectedCounties.remove(.fejer)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.gyormosonsopron)
                    } else {
                        selectedCounties.remove(.gyormosonsopron)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.hajdubihar)
                    } else {
                        selectedCounties.remove(.hajdubihar)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.heves)
                    } else {
                        selectedCounties.remove(.heves)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.jasznagykunszolnok)
                    } else {
                        selectedCounties.remove(.jasznagykunszolnok)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.komaromesztergom)
                    } else {
                        selectedCounties.remove(.komaromesztergom)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.nograd)
                    } else {
                        selectedCounties.remove(.nograd)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.somogy)
                    } else {
                        selectedCounties.remove(.somogy)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.szabolcsszatmarbereg)
                    } else {
                        selectedCounties.remove(.szabolcsszatmarbereg)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.tolna)
                    } else {
                        selectedCounties.remove(.tolna)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.vas)
                    } else {
                        selectedCounties.remove(.vas)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.veszprem)
                    } else {
                        selectedCounties.remove(.veszprem)
                    }
                    
                    if Bool.random() {
                        selectedCounties.insert(.zala)
                    } else {
                        selectedCounties.remove(.zala)
                    }
                    
                    print("Good: \(checkSelectedCounties(selectedCounties: selectedCounties.compactMap { $0 }))")
                }
        }
    }
    
    private func checkSelectedCounties(selectedCounties: [County]) -> Bool {
        Log.log(WithCategory: "Dashboard", Message: "Selected countis: \(selectedCounties)", Type: .debug)
                        
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

struct HungaryMap: View {
    
    @Binding var selectedCounties: Set<County>
    
    var body: some View {
        ZStack {
            ForEach(County.allCases) { county in
                if selectedCounties.contains(county) {
                    Image(county.selectedImageName)
                        .resizable()
                } else {
                    Image(county.imageName)
                        .resizable()
                }
            }
        }
        .aspectRatio(313/188, contentMode: .fit)
    }
}

enum County: String, CaseIterable, Identifiable {
    
    case bacskiskun
    case budapest
    case pest
    case baranya
    case bekes
    case borsodabaujzemplen
    case csongradcsanad
    case fejer
    case gyormosonsopron
    case hajdubihar
    case heves
    case jasznagykunszolnok
    case komaromesztergom
    case nograd
    case somogy
    case szabolcsszatmarbereg
    case tolna
    case vas
    case veszprem
    case zala
    
    var id: String {
        return self.rawValue
    }
    
    var imageName: String {
        return self.rawValue
    }
    
    var selectedImageName: String {
        return self.rawValue + "_selected"
    }
    
    var neighbours: [County] {
        switch self {
        case .bacskiskun:
            return [.baranya, .tolna, .fejer, .pest, .jasznagykunszolnok, .csongradcsanad]
        case .budapest:
            return [.pest]
        case .pest:
            return [.budapest, .komaromesztergom, .nograd, .heves, .jasznagykunszolnok, .bacskiskun, .fejer]
        case .baranya:
            return [.somogy, .tolna, .bacskiskun]
        case .bekes:
            return [.csongradcsanad, .jasznagykunszolnok, .hajdubihar]
        case .borsodabaujzemplen:
            return [.nograd, .szabolcsszatmarbereg, .hajdubihar, .jasznagykunszolnok, .heves]
        case .csongradcsanad:
            return [.bacskiskun, .jasznagykunszolnok, .bekes]
        case .fejer:
            return [.komaromesztergom, .pest, .bacskiskun, .tolna, .somogy, .veszprem]
        case .gyormosonsopron:
            return [.vas, .veszprem, .komaromesztergom]
        case .hajdubihar:
            return [.borsodabaujzemplen, .szabolcsszatmarbereg, .bekes, .jasznagykunszolnok, .heves]
        case .heves:
            return [.nograd, .borsodabaujzemplen, .jasznagykunszolnok, .pest]
        case .jasznagykunszolnok:
            return [.pest, .heves, .borsodabaujzemplen, .hajdubihar, .bekes, .csongradcsanad, .bacskiskun]
        case .komaromesztergom:
            return [.gyormosonsopron, .veszprem, .fejer, .pest]
        case .nograd:
            return [.pest, .heves, .borsodabaujzemplen]
        case .somogy:
            return [.zala, .veszprem, .fejer, .tolna, .baranya]
        case .szabolcsszatmarbereg:
            return [.borsodabaujzemplen, .hajdubihar]
        case .tolna:
            return [.somogy, .fejer, .bacskiskun, .baranya]
        case .vas:
            return [.zala, .veszprem, .gyormosonsopron]
        case .veszprem:
            return [.vas, .gyormosonsopron, .komaromesztergom, .fejer, .somogy, .zala]
        case .zala:
            return [.vas, .veszprem, .somogy]
        }
    }
    
}

#Preview {
    DashboardScreen(parameters: .init(), routing: PreviewRouter())
}
