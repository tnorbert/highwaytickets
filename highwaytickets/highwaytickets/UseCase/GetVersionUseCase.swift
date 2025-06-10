//
//  GetVersionUseCase.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import Alamofire

protocol GetVersionUseCaseProtocol {
    func execute() async -> Swift.Result< (isNewer: Bool, isCritical: Bool), any Error>
}

struct VersionResponse: Codable {
    let isNewer: Bool
    let isCritical: Bool
}

struct GetVersionUseCase: GetVersionUseCaseProtocol {
    
    enum VersionEndpoints: NetworkServiceDescriptor {
        case version(applicationVersion: String)

        var needsAuthentication: Bool {
            switch self {
            case .version:
                return false
            }
        }
        
        var path: String {
            switch self {
            case .version:
                return "versions"
            }
        }
        
        var httpMethod: Alamofire.HTTPMethod {
            switch self {
            case .version:
                return .get
            }
        }
        
        var parameterEncoding: any Alamofire.ParameterEncoding {
            switch self {
            case .version:
                return URLEncoding.default
            }
        }
        
        var additionalHeaders: [Alamofire.HTTPHeader] {
            switch self {
            default:
                return []
            }
        }
        
        var parameters: [String : Any] {
            switch self {
            case .version(let applicationVersion):
                return ["version":applicationVersion,
                        "platform":"ios"]
            }
        }
    }
    
    let remoteProvider: NetworkServiceProtocol

    init(remoteProvider: NetworkServiceProtocol) {
        self.remoteProvider = remoteProvider
    }
    
    func execute() async -> Swift.Result< (isNewer: Bool, isCritical: Bool), any Error> {
        let appVersion: String = ApplicationConfiguration.shared.version
        
        //Normally, I have an endpoint for retrieving application versions so we can force the user to update the application if neccesarry. I left it here for demonstration purposes and I just return after half a second.
        
        try! await Task.sleep(for: .seconds(0.5))
        
        return .success((false, false))
        
//        let result = await remoteProvider.request(VersionEndpoints.version(applicationVersion: appVersion), responseModelType: VersionResponse.self)
//        
//        switch result {
//        case .success(let response):
//            return .success((isNewer: response.isNewer, isCritical: response.isCritical))
//        case .failure(let failure):
//            return .failure(failure)
//        }
    }
    
}

struct GetVersionUseCase_preview: GetVersionUseCaseProtocol {
    
    func execute() async -> Swift.Result< (isNewer: Bool, isCritical: Bool), any Error> {
        return .success((false, false))
    }
    
}
