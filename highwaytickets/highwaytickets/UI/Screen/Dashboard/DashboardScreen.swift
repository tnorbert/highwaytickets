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
    
    var body: some View {
        ZStack {
            Color.viewBackground.ignoresSafeArea()
                        
            HungaryMap()
                .border(.black)
            
        }
        
    }
    
}

struct HungaryMap: View {
    
    @State private var isBacskiskunSelected: Bool = false
    @State private var isBudapestSelected: Bool = false
    @State private var isPestSelected: Bool = false
    @State private var isBaranyaSelected: Bool = false
    @State private var isBekesSelected: Bool = false
    @State private var isBorsodabaujzemplenSelected: Bool = false
    @State private var isCsongradcsanadSelected: Bool = false
    @State private var isFejerSelected: Bool = false
    @State private var isGyormosonsopronSelected: Bool = false
    @State private var isHajdubiharSelected: Bool = false
    @State private var isHevesSelected: Bool = false
    @State private var isJasznagykunszolnokSelected: Bool = false
    @State private var isKomaromesztergomSelected: Bool = false
    @State private var isNogradSelected: Bool = false
    @State private var isSomogySelected: Bool = false
    @State private var isSzabolcsszatmarberegSelected: Bool = false
    @State private var isTolnaSelected: Bool = false
    @State private var isVasSelected: Bool = false
    @State private var isVeszpremSelected: Bool = false
    @State private var isZalaSelected: Bool = false

    var body: some View {
        ZStack {
            Image(isBacskiskunSelected ? "bacskiskun_selected" : "bacskiskun")
                .resizable()
            
            Image(isBaranyaSelected ? "baranya_selected" : "baranya")
                .resizable()
                
            Image(isBekesSelected ? "bekes_selected" : "bekes")
                .resizable()
                
            Image(isBorsodabaujzemplenSelected ? "borsodabaujzemplen_selected" : "borsodabaujzemplen")
                .resizable()
                
            Image(isBudapestSelected ? "budapest_selected" : "budapest")
                .resizable()
            
            Image(isPestSelected ? "pest_selected" : "pest")
                .resizable()
            
            Image(isCsongradcsanadSelected ? "csongradcsanad_selected" : "csongradcsanad")
                .resizable()
                
            Image(isFejerSelected ? "fejer_selected" :"fejer")
                .resizable()
                
            Image(isGyormosonsopronSelected ? "gyormosonsopron_selected" :"gyormosonsopron")
                .resizable()
                
            Image(isHajdubiharSelected ? "hajdubihar_selected" : "hajdubihar")
                .resizable()
                
            Image(isHevesSelected ? "heves_selected" :"heves")
                .resizable()
                
            Image(isJasznagykunszolnokSelected ? "jasznagykunszolnok_selected" : "jasznagykunszolnok")
                .resizable()
                
            Image(isKomaromesztergomSelected ? "komaromesztergom_selected" :"komaromesztergom")
                .resizable()
                
            Image(isNogradSelected ? "nograd_selected" : "nograd")
                .resizable()
            
            Image(isSomogySelected ? "somogy_selected" : "somogy")
                .resizable()
                
            Image(isSzabolcsszatmarberegSelected ? "szabolcsszatmarbereg_selected" : "szabolcsszatmarbereg")
                .resizable()
                
            Image(isTolnaSelected ? "tolna_selected" : "tolna")
                .resizable()
                
            Image(isVasSelected ? "vas_selected" : "vas")
                .resizable()
                
            Image(isVeszpremSelected ? "veszprem_selected" : "veszprem")
                .resizable()
                
            Image(isZalaSelected ? "zala_selected" : "zala")
                .resizable()
                
        }
        .aspectRatio(313/188, contentMode: .fit)
        .onTapGesture {
            isBacskiskunSelected = .random()
            isBudapestSelected = false
            isPestSelected = .random()
            isBaranyaSelected = .random()
            isBekesSelected = .random()
            isBorsodabaujzemplenSelected = .random()
            isCsongradcsanadSelected = .random()
            isFejerSelected = .random()
            isGyormosonsopronSelected = .random()
            isHajdubiharSelected = .random()
            isHevesSelected = .random()
            isJasznagykunszolnokSelected = .random()
            isKomaromesztergomSelected = .random()
            isNogradSelected = .random()
            isSomogySelected = .random()
            isSzabolcsszatmarberegSelected = .random()
            isTolnaSelected = .random()
            isVasSelected = .random()
            isVeszpremSelected = .random()
            isZalaSelected = .random()
            
            var selectedCounties: [County] = []
            
            if isBacskiskunSelected {
                selectedCounties.append(.bacskiskun)
            }
            
            if isBudapestSelected {
                selectedCounties.append(.budapest)
            }
            
            if isPestSelected {
                selectedCounties.append(.pest)
            }
            
            if isBaranyaSelected {
                selectedCounties.append(.baranya)
            }
            
            if isBekesSelected {
                selectedCounties.append(.bekes)
            }
            
            if isBorsodabaujzemplenSelected {
                selectedCounties.append(.borsodabaujzemplen)
            }
            
            if isCsongradcsanadSelected {
                selectedCounties.append(.csongradcsanad)
            }
            
            if isFejerSelected {
                selectedCounties.append(.fejer)
            }
            
            if isGyormosonsopronSelected {
                selectedCounties.append(.gyormosonsopron)
            }
            
            if isHajdubiharSelected {
                selectedCounties.append(.hajdubihar)
            }
            
            if isHevesSelected {
                selectedCounties.append(.heves)
            }
            
            if isJasznagykunszolnokSelected {
                selectedCounties.append(.jasznagykunszolnok)
            }
            
            if isKomaromesztergomSelected {
                selectedCounties.append(.komaromesztergom)
            }
            
            if isNogradSelected {
                selectedCounties.append(.nograd)
            }
            
            if isSomogySelected {
                selectedCounties.append(.somogy)
            }
            
            if isSzabolcsszatmarberegSelected {
                selectedCounties.append(.szabolcsszatmarbereg)
            }
            
            if isTolnaSelected {
                selectedCounties.append(.tolna)
            }
            
            if isVasSelected {
                selectedCounties.append(.vas)
            }
            
            if isVeszpremSelected {
                selectedCounties.append(.veszprem)
            }
            
            if isZalaSelected {
                selectedCounties.append(.zala)
            }
            
            print("Good: \(checkSelectedCounties(selectedCounties: selectedCounties))")
        }
    }
    
    private func checkSelectedCounties(selectedCounties: [County]) -> Bool {
        Log.log(WithCategory: "Dashboard", Message: "Selected countis: \(selectedCounties)", Type: .debug)
        
        guard let firstSelectedCountry = selectedCounties.first else {
            return false
        }
        
        var visitedCounties: Set<County> = []
        var stack: [County] = [firstSelectedCountry]
        
        while let current = stack.popLast() {
            if visitedCounties.contains(current) {
                continue
            }
            
            visitedCounties.insert(current)
            
            let validNeighbors = current.neighbours.filter { selectedCounties.contains($0) }
            stack.append(contentsOf: validNeighbors)
        }
        
        guard visitedCounties.count == selectedCounties.count else {
            return false
        }
        
        return true
    }
    
}

enum County {
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
