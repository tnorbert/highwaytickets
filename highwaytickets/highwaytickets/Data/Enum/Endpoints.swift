//
//  Endpoints.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 09..
//

import Foundation
import Alamofire

enum Endpoints: NetworkServiceDescriptor {

    case highwayVignetteInformation
    case vehicleInformation
    case orderHighwayVignettes(vignettes: [HighwayVignette], vehicleInformation: VehicleInformation)
    
    var needsAuthentication: Bool {
        return false
    }
    
    var path: String {
        switch self {
            
        case .highwayVignetteInformation:
            return "highway/info"
        case .vehicleInformation:
            return "highway/vehicle"
        case .orderHighwayVignettes:
            return "highway/order"
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
            
        case .highwayVignetteInformation:
            return .get
        case .vehicleInformation:
            return .get
        case .orderHighwayVignettes:
            return .post
        }
    }
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
            
        case .highwayVignetteInformation:
            return URLEncoding.default
        case .vehicleInformation:
            return URLEncoding.default
        case .orderHighwayVignettes:
            return JSONEncoding.default
        }
    }
    
    var additionalHeaders: [Alamofire.HTTPHeader] {
        switch self {
            
        case .highwayVignetteInformation:
            return []
        case .vehicleInformation:
            return []
        case .orderHighwayVignettes:
            return []
        }
    }
    
    var parameters: [String : Any] {
        switch self {
            
        case .highwayVignetteInformation:
            return [:]
        case .vehicleInformation:
            return [:]
        case .orderHighwayVignettes(vignettes: let vignettes, vehicleInformation: let vehicleInformation):
            
            var vignettesToSend: [[String: Any]] = []
            
            for vignette in vignettes {
                vignettesToSend.append(["type":vignette.type.rawValue,
                                        "cost":vignette.price,
                                        "category": vehicleInformation.type])
            }
            
            return ["highwayOrders": vignettesToSend]
        }
    }
    
}

struct HighwayVignetteInformationResponse: Codable {
    let dataType: String
    let payload: HighwayVignetteInformationDTO
    let requestId: Int
    let statusCode: String
}

struct VehicleInformationResponse: Codable {
    let internationalRegistrationCode: String
    let name: String
    let plate: String
    let requestId: Int
    let statusCode: String
    let vignetteType: String
    let type: String
}

struct OrderHighwayVignettesResponse: Codable {

}
