//
//  BackendError.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation

enum BackendError: Int, Error, Equatable, RawRepresentable, LocalizedError, Identifiable {
    
    var id: Int {
        return code
    }
    
    ///The error is not known
    case unknownError = -1
    
    ///Something bad happend in the server, for example the response cannot be parsed
    case serverError = -2
    
    ///There is an error with the connection, ex.: No internet connection
    case networkError = -3
    
    case cancelled = -4
    
    case unauthorized = -5
    
    case tooManyRequests = -6
    
    case incorrentEmailOrPassword = -32104
    
    case invalidAccessToken = 10500

    typealias RawValue = Int
    
    init(rawValue: Int) {
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
        case -32104:
            self = .incorrentEmailOrPassword
        case 10500:
            self = .invalidAccessToken
        default:
            self = .unknownError
        }
    }
    
    //MARK: - Properties
    
    /*
    Localized description of the error.
    */
    var localizedDescription: String {
        return "backendError_\(self)_text".localized()
    }
    
    /*
    Localized description of the error.
    */
    var errorDescription: String? {
        return "backendError_\(self)_text".localized()
    }
    
    /*
     Localized title of the error.
     */
    var localizedTitle: String {
        return "backendError_\(self)_title".localized()
    }
    
    /*
     Code of the error.
     */
    var code: Int {
        return self.rawValue
    }
    
}
