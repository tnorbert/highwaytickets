//
//  NetworkServiceProtocol.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation

protocol NetworkServiceProtocol {
    func request<ResponseModel: Codable>(_ endpoint: NetworkServiceDescriptor, responseModelType: ResponseModel.Type) async -> Swift.Result<ResponseModel, Error>
}
