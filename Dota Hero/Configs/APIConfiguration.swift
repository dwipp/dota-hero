//
//  APIConfiguration.swift
//  Dota Hero
//
//  Created by Dwi Putra on 04/12/20.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod {get}
    var path: String {get}
    var parameters: RequestParams {get}
}
