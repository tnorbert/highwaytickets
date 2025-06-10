//
//  BuyVignettesUseCase.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

protocol BuyVignettesUseCaseProtocol {
    func execeute(vignettes: [HighwayVignette], vehicleInformation: VehicleInformation) async -> Swift.Result<Void, Error>
}

struct BuyVignettesUseCase: BuyVignettesUseCaseProtocol {
    
    let remoteProvider: NetworkServiceProtocol
    
    init(remoteProvider: NetworkServiceProtocol) {
        self.remoteProvider = remoteProvider
    }
    
    func execeute(vignettes: [HighwayVignette], vehicleInformation: VehicleInformation) async -> Swift.Result<Void, Error> {
        let result = await remoteProvider.request(Endpoints.orderHighwayVignettes(vignettes: vignettes, vehicleInformation: vehicleInformation), responseModelType: OrderHighwayVignettesResponse.self)
        
        switch result {
        case .success(_):
            //Since the backend is running locally, we need to have some artificial "delay" on the calls
            try? await Task.sleep(for: .seconds(1))
            
            return .success(Void())
        case .failure(let failure):
            return .failure(failure)
        }
    }
    
}

struct BuyVignettesUseCase_preview: BuyVignettesUseCaseProtocol {
    
    func execeute(vignettes: [HighwayVignette], vehicleInformation: VehicleInformation) async -> Result<Void, any Error> {
        return .success(Void())
    }
    
}
 
