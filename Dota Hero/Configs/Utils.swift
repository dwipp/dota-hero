//
//  Utils.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import Foundation

struct Utils {
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
