//
//  GetHighwayVignetteInformationUseCase.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import Foundation

protocol GetHighwayVignetteInformationUseCaseProtocol {
    func execute() async -> Swift.Result<HighwayVignetteInformation, Error>
}

struct GetHighwayVignetteInformationUseCase: GetHighwayVignetteInformationUseCaseProtocol {
    
    let remoteProvider: NetworkServiceProtocol
    
    init(remoteProvider: NetworkServiceProtocol) {
        self.remoteProvider = remoteProvider
    }
    
    func execute() async -> Swift.Result<HighwayVignetteInformation, Error> {
        let result = await remoteProvider.request(Endpoints.highwayVignetteInformation, responseModelType: HighwayVignetteInformationResponse.self)
        
        switch result {
        case .success(let response):
            return .success(.init(response: response))
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
}

struct GetHighwayVignetteInformationUseCase_preview: GetHighwayVignetteInformationUseCaseProtocol {
    
    func execute() async  -> Swift.Result<HighwayVignetteInformation, Error> {
        return .failure(NSError(domain: "", code: 1))
    }
    
}

struct HighwayVignette: Hashable {
    let type: HighwayVignetteType
    let price: Int
    
    var name: String {
        switch type {
        case .day:
            //TODO: - Localize
            return "D1 - napi (1 napos)"
        case .week:
            return "D1 - heti (10 napos)"
        case .month:
            return "D1 - havi"
        }
    }
}

enum HighwayVignetteType: String {
    case day = "DAY"
    case week = "WEEK"
    case month = "MONTH"
}

struct HighwayVignetteInformation {
    
    let highwayVignettes: [HighwayVignette]
    
    init(response: HighwayVignetteInformationResponse) {
        
        var highwayVignettes: [HighwayVignette] = []
        
        for vignette in response.payload.highwayVignettes {
            switch vignette.vignetteType {
            case .day:
                highwayVignettes.append(.init(type: .day, price: vignette.cost))
            case .week:
                highwayVignettes.append(.init(type: .week, price: vignette.cost))
            case .month:
                highwayVignettes.append(.init(type: .month, price: vignette.cost))
            case .year:
                break
            }
        }
        
        self.highwayVignettes = highwayVignettes
        
    }
    
}

struct VehicleInformation {
    
    let name: String
    let plate: String
    let vignetteType: String
    let type: String
    
    init(response: VehicleInformationResponse) {
        self.name = response.name
        self.plate = response.plate
        self.vignetteType = response.vignetteType
        self.type = response.type
    }
    
    init(name: String, plate: String, vignetteType: String, type: String) {
        self.name = name
        self.plate = plate
        self.vignetteType = vignetteType
        self.type = type
    }
    
}
