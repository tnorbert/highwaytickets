//
//  GetHighwayVignetteInformationUseCase.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import Foundation
import SwiftUI

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
            //Since the backend is running locally, we need to have some artificial "delay" on the calls
            try? await Task.sleep(for: .milliseconds(250))
            
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
