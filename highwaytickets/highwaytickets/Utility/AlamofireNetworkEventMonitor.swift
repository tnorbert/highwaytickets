//
//  AlamofireNetworkEventMonitor.swift
//  highwaytickets
//
//  Created by Tomo Norbert on 2025. 06. 05..
//

import Foundation
import Alamofire

protocol AlamofireNetworkEventMonitorDelegate: AnyObject {
    func didFinishServingRequest(WithRequest request: URLRequest?, Response response: HTTPURLResponse?, ServerData serverData: Data?, SerializedResponse serializedResponse: String)
}

final class AlamofireNetworkEventMonitor: EventMonitor {
    
    weak var delegate: AlamofireNetworkEventMonitorDelegate? = nil
    
    func request(_ request: Request, didCreateURLRequest urlRequest: URLRequest) {
        let httpBodyData: Data? = request.request?.httpBody
        
        let text: String =
        """
        Request URL:
        \(request.request?.description ?? ""))
        
        HTTP Method:
        \(request.request?.httpMethod ?? "")
        
        HTTP Request header fields:
        \(request.request?.allHTTPHeaderFields ?? [String:String]())
        
        HTTP Request body:
        \(httpBodyData != nil ? "\(String(data: httpBodyData!, encoding: .utf8) ?? "")" : "")
        """
        
        Log.log(WithCategory: "NetworkEventMonitor", Message: "Did create url request:\n\(text)", Type: .info, CustomIcon: UniqueSymbols.globe.rawValue)
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        var serializedResponse = ""
        
        do {
            if let data = response.data {
                let json = try JSONSerialization.jsonObject(with: data)
                
                if let dictionary = json as? NSDictionary {
                    serializedResponse = String(describing: dictionary)
                }
            }
        } catch { }
        
        if serializedResponse.isEmpty, let httpResponseBodyData = response.data {
            serializedResponse = String(data: httpResponseBodyData, encoding: .utf8) ?? ""
        }
        
        let httpRequestBodyData = request.request?.httpBody
        
        var text =
        """
        Request URL:
        \(request.request?.description ?? ""))
        
        Status code:
        \(request.response?.statusCode ?? -1)
        
        HTTP Method:
        \(request.request?.httpMethod ?? "")
        
        HTTP Request header fields:
        \(request.request?.allHTTPHeaderFields ?? [String:String]())
        
        HTTP Request body:
        \(httpRequestBodyData != nil ? "\(String(data: httpRequestBodyData!, encoding: .utf8) ?? "")" : "")
        
        HTTP Response header fields:
        \(request.response?.allHeaderFields as? [String:String] ?? [String:String]())
        
        Server Data:
        \(String(describing: response.data))
        
        Result of response serialization:
        \(serializedResponse)
        """
        
        switch response.result {
        case .success(_):
            Log.log(WithCategory: "NetworkEventMonitor", Message: "Did finish serving a request:\n\(text)", Type: .info, CustomIcon: UniqueSymbols.globe.rawValue)
        case .failure(let error):
            text +=
            """
            
            Error:
            \(error.localizedDescription)
            """
            
            Log.log(WithCategory: "NetworkEventMonitor", Message: "Did finish serving a request:\n\(text)", Type: .error, CustomIcon: UniqueSymbols.globe.rawValue)
        }
        
        delegate?.didFinishServingRequest(WithRequest: request.request, Response: request.response, ServerData: response.data, SerializedResponse: serializedResponse)
    }
    
}

