//
//  APIProvider.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import Alamofire

//MARK: - APIProvider

class APIProvider: NetworkServiceProtocol {
    
    private let networkService: AlamofireNetworkService
    private let baseURL: URL
    private let backendVersion: APIVersion
    
    deinit {
        Log.log(WithCategory: "APIProvider", Message: "deinit()", Type: .debug)
    }
    
    init() {
        baseURL = ApplicationConfiguration.shared.apiBaseUrl
        backendVersion = .v1
        networkService = AlamofireNetworkService.shared
    }
    
    func request<ResponseModel>(_ endpoint: NetworkServiceDescriptor, responseModelType: ResponseModel.Type) async -> Result<ResponseModel, Error> where ResponseModel : Decodable, ResponseModel : Encodable {
        
        var headers: HTTPHeaders = HTTPHeaders()
        
        headers.add(HTTPHeader(name: "App-Platform", value: "ios"))
        
        for header in endpoint.additionalHeaders {
            headers.add(header)
        }

        Log.log(WithCategory: "APIProvider", Message: "Calling '\(endpoint.path)' with parameters '\(endpoint.parameters)'", Type: .info, CustomIcon: UniqueSymbols.globe.rawValue)
        
        let urlToSend = URL(string: "\(baseURL.absoluteString)/\(backendVersion.rawValue)/\(endpoint.path)")!
        
        let result = await networkService.sendRequestAsync(ToURL: urlToSend, WithParameters: endpoint.parameters, Method: endpoint.httpMethod, Headers: headers, ParameterEncoding: endpoint.parameterEncoding)
        
        switch result {
        case .success(let data):
            do {
                let jsonDecoder = JSONDecoder()
                
                let dateTimeFormatter = DateFormatter()
                dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                jsonDecoder.dateDecodingStrategyFormatters = [dateTimeFormatter,
                                                              dateFormatter]
                
                let resultModel = try jsonDecoder.decode(ResponseModel.self, from: data)
                
                return .success(resultModel)
            } catch {
                return .failure(BackendError.serverError)
            }
        case .failure(let failure):
            switch failure {
            case .unknownError:
                return .failure(BackendError.unknownError)
            case .serverError:
                return .failure(BackendError.serverError)
            case .networkError:
                return .failure(BackendError.networkError)
            case .cancelled:
                return .failure(BackendError.cancelled)
            case .customError(let value):
                let error = BackendError.init(rawValue: value)
                
                return .failure(error)
            case .unauthorized:
                if endpoint.needsAuthentication {
                    return .failure(BackendError.unauthorized)
                } else {
                    return .failure(BackendError.unauthorized)
                }
            case .tooManyRequests:
                return .failure(BackendError.tooManyRequests)
            }
        }
    }
    
}
