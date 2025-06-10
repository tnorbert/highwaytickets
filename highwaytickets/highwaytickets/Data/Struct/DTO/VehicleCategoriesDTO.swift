//
//  VehicleCategoriesDTO.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 10..
//

import Foundation

struct VehicleCategoriesDTO: Codable {
    let category: String
    let vignetteCategory: String
    let name: VehicleCategoryNameDTO
}
