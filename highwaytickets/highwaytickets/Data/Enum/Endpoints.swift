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
    
    var needsAuthentication: Bool {
        return false
    }
    
    var path: String {
        switch self {
            
        case .highwayVignetteInformation:
            return "highway/info"
        }
    }
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
            
        case .highwayVignetteInformation:
            return .get
        }
    }
    
    var parameterEncoding: any Alamofire.ParameterEncoding {
        switch self {
            
        case .highwayVignetteInformation:
            return URLEncoding.default
        }
    }
    
    var additionalHeaders: [Alamofire.HTTPHeader] {
        switch self {
            
        case .highwayVignetteInformation:
            return []
        }
    }
    
    var parameters: [String : Any] {
        switch self {
            
        case .highwayVignetteInformation:
            return [:]
        }
    }
    
}

struct HighwayVignetteInformationDTO: Codable {
    let counties: [CountyDTO]
    let highwayVignettes: [HighwayVignettesDTO]
    let vehicleCategories: [VehicleCategoriesDTO]
}

struct CountyDTO: Codable {
    let id: String
    let name: String
}

struct HighwayVignettesDTO: Codable {
    let cost: Int
    let sum: Int
    let trxFee: Int
    let vehicleCategory: String
    let vignetteType: VignetteType
    
    enum CodingKeys: String, CodingKey {
        case cost, sum, trxFee, vehicleCategory, vignetteType
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cost = try container.decode(Int.self, forKey: .cost)
        self.sum = try container.decode(Int.self, forKey: .sum)
        self.trxFee = try container.decode(Int.self, forKey: .trxFee)
        self.vehicleCategory = try container.decode(String.self, forKey: .vehicleCategory)
        
        if let array = try? container.decode([String].self, forKey: .vignetteType) {
            if array.count == 1 {
                if let enumValue = VignetteType(rawValue: array[0]) {
                    self.vignetteType = enumValue
                } else {
                    throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid VignetteType"))
                }
            } else if array.contains(where: { $0.hasPrefix("YEAR") }) {
                vignetteType = .year
            } else {
                throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid VignetteType"))
            }
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid VignetteType"))
        }
    }
    
}

enum VignetteType: Codable {
    case day
    case month
    case week
    case year
    
    enum CodingKeys: String, CodingKey {
        case day = "DAY"
        case month = "MONTH"
        case week = "WEEK"
        case year = "YEAR"
    }
    
    init(from decoder: any Decoder) throws {
        try decoder.container(keyedBy: CodingKeys.self)
        
        self = .day
    }
    
    init?(rawValue: [String]) {
        return nil
    }
    
    init?(rawValue: String) {
        switch rawValue {
        case "DAY":
            self = .day
        case "MONTH":
            self = .month
        case "WEEK":
            self = .week
        case "YEAR":
            self = .year
        default:
            return nil
        }
    }
}

struct VehicleCategoriesDTO: Codable {
    let category: String
    let vignetteCategory: String
    let name: VehicleCategoryNameDTO
}

struct VehicleCategoryNameDTO: Codable {
    let en: String
    let hu: String
}



struct HighwayVignetteInformationResponse: Codable {
    let dataType: String
    let payload: HighwayVignetteInformationDTO
    let requestId: Int
    let statusCode: String
}
