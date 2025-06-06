//
//  NetworkServiceDescriptor.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import Alamofire

protocol NetworkServiceDescriptor {
    var needsAuthentication: Bool { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameterEncoding: ParameterEncoding { get }
    var additionalHeaders: [HTTPHeader] { get }
    var parameters: [String: Any] { get }
}
