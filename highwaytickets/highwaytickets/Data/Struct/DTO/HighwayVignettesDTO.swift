//
//  HighwayVignettesDTO.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 10..
//

import Foundation

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
