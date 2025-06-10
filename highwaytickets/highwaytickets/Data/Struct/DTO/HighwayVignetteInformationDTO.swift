//
//  HighwayVignetteInformationDTO.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 10..
//

import Foundation

struct HighwayVignetteInformationDTO: Codable {
    let counties: [CountyDTO]
    let highwayVignettes: [HighwayVignettesDTO]
    let vehicleCategories: [VehicleCategoriesDTO]
}
