//
//  AlamofireNetworkService.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import Alamofire
import UIKit

final class AlamofireNetworkService {
    
    //MARK: - Properties -
    
    static let shared: AlamofireNetworkService = AlamofireNetworkService()
    
    private let _sessionManager: Session
    
    private let _networkQueue: DispatchQueue = .global(qos: .userInitiated)
    
    //MARK: - Life cycle methods -
    
    deinit { }
    
    private init() {
        let trustManager: ServerTrustManager = ServerTrustManager(allHostsMustBeEvaluated: false, evaluators: [:])
        
        let configuration: URLSessionConfiguration = URLSessionConfiguration.af.default
        
        let eventMonitor: AlamofireNetworkEventMonitor = AlamofireNetworkEventMonitor()
        eventMonitor.delegate = UIApplication.shared.delegate as? AppDelegate

        _sessionManager = Session(configuration: configuration, serverTrustManager: trustManager, eventMonitors: [eventMonitor])
    }
    
    //MARK: - Public methods -
    
    func logout() {
        Log.log(WithCategory: "AlamofireNetworkService", Message: "Logout called, cancelling all requests", Type: .info)
        
        _sessionManager.cancelAllRequests()
    }
    
    func sendRequestAsync(ToURL url: URL, WithParameters: [String: Any], Method: HTTPMethod, Headers: HTTPHeaders?, ParameterEncoding: ParameterEncoding) async -> Swift.Result<Data, NetworkError> {
        
        return await withCheckedContinuation { continuation in
            _sessionManager.request(url , method: Method, parameters: WithParameters, encoding: ParameterEncoding, headers: Headers, interceptor: nil, requestModifier: nil).responseData(queue: _networkQueue) { ResponseData in
                
                switch ResponseData.result {
                case .success(let data):
                    do {
                        let asJSON = try JSONSerialization.jsonObject(with: data)
                        
                        guard let statusCode = ResponseData.response?.statusCode else {
                            continuation.resume(returning: .failure(.unknownError))
                            return
                        }
                        
                        if statusCode >= 200 && statusCode < 300 {
                            //Success
                            continuation.resume(returning: .success(data))
                        } else if statusCode == 401 {
                            continuation.resume(returning: .failure(.unauthorized))
                        } else if statusCode == 429 {
                            continuation.resume(returning: .failure(.tooManyRequests))
                        } else if statusCode >= 400 && statusCode < 600 {
                            //Client error
                            guard let responseDict = asJSON as? NSDictionary else {
                                continuation.resume(returning: .failure(.serverError))
                                return
                            }
                            
                            if let code = responseDict.value(forKey: "code") as? Int {
                                continuation.resume(returning: .failure(.customError(code)))
                            } else {
                                continuation.resume(returning: .failure(.serverError))
                            }
                        } else {
                            //Unknown error
                            continuation.resume(returning: .failure(.unknownError))
                        }
                    } catch (let error) {
                        Log.log(WithCategory: "AlamofireNetworkService", Message: "Error: \(error.localizedDescription)", Type: .error)
                        continuation.resume(returning: .failure(.serverError))
                    }
                case .failure(let error):
                    Log.log(WithCategory: "AlamofireNetworkService", Message: "Error: \(error.localizedDescription), reason: \(error.failureReason ?? ""), ", Type: .error)
                    
                    if error.isExplicitlyCancelledError {
                        continuation.resume(returning: .failure(.cancelled))
                    } else if error.isSessionTaskError {
                        continuation.resume(returning: .failure(.networkError))
                    } else {
                        continuation.resume(returning: .failure(.serverError))
                    }
                }
            }
        }
    }
    
}
