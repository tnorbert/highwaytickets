//
//  GetAppstoreVersionUseCase.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import Alamofire

protocol GetAppstoreVersionUseCaseProtocol {
    func execute() async -> Swift.Result<String, BackendError>
}

struct GetAppstoreVersionUseCase: GetAppstoreVersionUseCaseProtocol {
    
    private let _sessionManager: Session
    private let _networkQueue: DispatchQueue = .global(qos: .userInitiated)
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        
        _sessionManager = Session(configuration: configuration, serverTrustManager: nil, eventMonitors: [])
    }
    
    func execute() async -> Swift.Result<String, BackendError> {
        let parameters: [String: Any] = ["bundleId": ApplicationConfiguration.shared.bundleId]
                
        let urlToSend = URL(string: "https://itunes.apple.com/lookup")!
        
        return await withCheckedContinuation { continuation in
            _ = sendRequest(ToURL: urlToSend, WithParameters: parameters, Method: .get, Headers: HTTPHeaders(), ParameterEncoding: URLEncoding.default) { (result) in
                switch result {
                case .success(let responseValues):
                    guard let responseDictionary = responseValues as? NSDictionary else {
                        return continuation.resume(returning: .failure(.serverError))
                    }
                    
                    guard let resultsArray = responseDictionary.value(forKey: "results") as? NSArray else {
                        return continuation.resume(returning: .failure(.serverError))
                    }
                    
                    guard resultsArray.count > 0 else {
                        return continuation.resume(returning: .failure(.serverError))
                    }
                    
                    guard let resultsDictionary = resultsArray[0] as? NSDictionary else {
                        return continuation.resume(returning: .failure(.serverError))
                    }
                    
                    guard let version = resultsDictionary.value(forKey: "version") as? String else {
                        return continuation.resume(returning: .failure(.serverError))
                    }
                    
                    return continuation.resume(returning: .success(version))
                case .failure(let error):
                    switch error {
                    case .unknownError:
                        return continuation.resume(returning: .failure(.unknownError))
                    case .serverError:
                        return continuation.resume(returning: .failure(.serverError))
                    case .networkError:
                        return continuation.resume(returning: .failure(.networkError))
                    case .cancelled:
                        return continuation.resume(returning: .failure(.cancelled))
                    case .customError(let value):
                        return continuation.resume(returning: .failure(.init(rawValue: value)))
                    case .unauthorized:
                        return continuation.resume(returning: .failure(.unauthorized))
                    case .tooManyRequests:
                        return continuation.resume(returning: .failure(.tooManyRequests))
                    }
                }
            }
        }
    }
    
    private func sendRequest(ToURL url: URL, WithParameters: [String: Any], Method: HTTPMethod, Headers: HTTPHeaders?, ParameterEncoding: ParameterEncoding, completionHandler: @escaping (Swift.Result<Any, NetworkError>) -> Void) -> DataRequest {
        
        let request = _sessionManager.request(url , method: Method, parameters: WithParameters, encoding: ParameterEncoding, headers: Headers, interceptor: nil, requestModifier: nil).responseData(queue: _networkQueue) { ResponseData in
            
            DispatchQueue.main.async {
                switch ResponseData.result {
                case .success(let data):
                    do {
                        let asJSON = try JSONSerialization.jsonObject(with: data)
                        
                        guard let statusCode = ResponseData.response?.statusCode else {
                            completionHandler(.failure(.unknownError))
                            return
                        }
                        
                        if statusCode >= 200 && statusCode < 300 {
                            //Success
                            completionHandler(.success(asJSON))
                        } else if statusCode >= 400 && statusCode < 600 {
                            if statusCode == 401 {
                                completionHandler(.failure(.unauthorized))
                            } else if statusCode == 429 {
                                completionHandler(.failure(.tooManyRequests))
                            } else {
                                //Client error
                                guard let responseDict = asJSON as? NSDictionary else {
                                    completionHandler(.failure(.serverError))
                                    return
                                }
                                
                                if let code = responseDict.value(forKey: "code") as? Int {
                                    completionHandler(.failure(.customError(code)))
                                } else {
                                    completionHandler(.failure(.serverError))
                                }
                            }
                        } else {
                            //Unknown error
                            completionHandler(.failure(.unknownError))
                        }
                    } catch (let error) {
                        Log.log(WithCategory: "GetAppstoreVersionUseCase", Message: "Error: \(error.localizedDescription)", Type: .error)
                        completionHandler(.failure(.serverError))
                    }
                case .failure(let error):
                    Log.log(WithCategory: "GetAppstoreVersionUseCase", Message: "Error: \(error.localizedDescription), reason: \(error.failureReason ?? ""), ", Type: .error)
                    
                    if error.isExplicitlyCancelledError {
                        completionHandler(.failure(.cancelled))
                    } else if error.isSessionTaskError {
                        completionHandler(.failure(.networkError))
                    } else {
                        completionHandler(.failure(.serverError))
                    }
                }
            }
        }
        
        return request
    }
    
}

struct GetAppstoreVersionUseCase_preview: GetAppstoreVersionUseCaseProtocol {
    
    func execute() async -> Swift.Result<String, BackendError> {
        return .success("")
    }
    
}
