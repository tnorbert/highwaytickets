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
    var type: HighwayVignetteType
    
    var name: String {
        return "sajt"
    }
}

enum HighwayVignetteType {
    case day
    case week
    case month
}

struct HighwayVignetteInformation {
    
    let highwayVignettes: [HighwayVignette]
    
    init(response: HighwayVignetteInformationResponse) {
        
        var highwayVignettes: [HighwayVignette] = []
        
        for vignette in response.payload.highwayVignettes {
            switch vignette.vignetteType {
            case .day:
                highwayVignettes.append(.init(type: .day))
            case .week:
                highwayVignettes.append(.init(type: .week))
            case .month:
                highwayVignettes.append(.init(type: .month))
            case .year:
                break
            }
        }
        
        self.highwayVignettes = highwayVignettes
        
    }
    
}
