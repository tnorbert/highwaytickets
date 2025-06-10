//
//  VehicleInformation.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 10..
//

import Foundation

struct VehicleInformation {
    
    let name: String
    let plate: String
    let vignetteType: String
    let type: String
    
    init(response: VehicleInformationResponse) {
        self.name = response.name
        self.plate = response.plate
        self.vignetteType = response.vignetteType
        self.type = response.type
    }
    
    init(name: String, plate: String, vignetteType: String, type: String) {
        self.name = name
        self.plate = plate
        self.vignetteType = vignetteType
        self.type = type
    }
    
}
