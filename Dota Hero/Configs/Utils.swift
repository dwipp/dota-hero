//
//  Utils.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import Foundation
import Alamofire

struct Utils {
    let reachability = NetworkReachabilityManager(host: Constants.ProductionServer.baseURL)!
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func isReachable() -> Bool {
        return reachability.isReachable
    }
    
    let deviceWidth: CGFloat = {
        return UIWindow.isLandscape ? UIScreen.main.bounds.height : UIScreen.main.bounds.width
    }()
    
    let deviceHeight: CGFloat = {
        return UIWindow.isLandscape ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
    }()
    
}
