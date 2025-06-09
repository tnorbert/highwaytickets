//
//  GetVehicleInformationUseCase.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import Foundation

protocol GetVehicleInformationUseCaseProtocol {
    func execute() async -> Swift.Result<VehicleInformation, Error>
}

struct GetVehicleInformationUseCase: GetVehicleInformationUseCaseProtocol {
    
    let remoteProvider: NetworkServiceProtocol
    
    init(remoteProvider: NetworkServiceProtocol) {
        self.remoteProvider = remoteProvider
    }
    
    func execute() async -> Swift.Result<VehicleInformation, Error> {
        let result = await remoteProvider.request(Endpoints.vehicleInformation, responseModelType: VehicleInformationResponse.self)
        
        switch result {
        case .success(let response):
            return .success(.init(response: response))
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
}

struct GetVehicleInformationUseCase_preview: GetVehicleInformationUseCaseProtocol {
    
    func execute() async -> Swift.Result<VehicleInformation, Error> {
        return .failure(NSError(domain: "", code: 1))
    }
    
}
