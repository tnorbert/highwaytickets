//
//  ProviderFactory.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation

final class ProviderFactory {
    
    private static let networkServiceProviderShared = APIProvider()
    
    static func networkServiceProvider() -> NetworkServiceProtocol {
        return networkServiceProviderShared
    }
    
}
