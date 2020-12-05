//
//  APIRouter.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import Foundation
import Alamofire

enum APIRouter: APIConfiguration {
    case heroList
    
    var method: HTTPMethod {
        switch self {
        case .heroList:
            return .get
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .heroList:
            return .url([:])
        }
    }
    
    var path: String {
        switch self {
        case .heroList:
            return "/herostats"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = try Constants.ProductionServer.baseURL.asURL()
        #if DEBUG
            url = try Constants.DevelopmentServer.baseURL.asURL()
        #endif
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch parameters {
        case .body(let params):
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .url(let params):
            let queryParams = params.map { pair in
                return URLQueryItem(name: pair.key, value: "\(pair.value)")
            }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        }
        return urlRequest
    }
    
    
}
