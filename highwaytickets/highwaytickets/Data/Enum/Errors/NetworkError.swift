//
//  NetworkError.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation

enum NetworkError: Error, Equatable, RawRepresentable {
    
    ///The error is not known
    case unknownError

    ///Something bad happend in the server, for example the response cannot be parsed
    case serverError

    ///There is an error with the connection, ex.: No internet connection
    case networkError

    ///The request has been cancelled
    case cancelled

    ///401 - Unauthorized
    case unauthorized
    
    ///429 - Too many requests
    case tooManyRequests

    case customError(Int)

    typealias RawValue = Int

    init?(rawValue: Int) {
        switch rawValue {
        case -1:
            self = .unknownError
        case -2:
            self = .serverError
        case -3:
            self = .networkError
        case -4:
            self = .cancelled
        case -5:
            self = .unauthorized
        case -6:
            self = .tooManyRequests
        default:
            self = .customError(rawValue)
        }
    }
    
    var rawValue: Int {
        switch self {
        
        case .unknownError:
            return -1
        case .serverError:
            return -2
        case .networkError:
            return -3
        case .cancelled:
            return -4
        case .unauthorized:
            return -5
        case .tooManyRequests:
            return -6
        case .customError(let customsize):
            return customsize
        }
    }
    
    var code: Int {
        return self.rawValue
    }

}
