//
//  Constants.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import Foundation
import Alamofire

struct Constants {
    struct ProductionServer {
        static let baseURL = "https://api.opendota.com/api"
    }
    struct DevelopmentServer {
        static let baseURL = "https://api.opendota.com/api"
    }
}

enum HTTPHeaderField:String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case string = "String"
}

enum ContentType:String {
    case  json = "Application/json"
    case formEncode = "application/x-www-form-urlencoded"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
}

enum Code:String {
    case noInternet = "no-internet"
    case success = "success"
    case error = "error"
    case empty = "empty"
}
