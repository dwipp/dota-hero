//
//  HeroDetailVM.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import Foundation

protocol DetailActionProtocol {
    
}

protocol DetailModelProtocol {
    var action: DetailActionProtocol? {get set}
    var hero: Hero? {get}
}

class HeroDetailVM: DetailModelProtocol {
    var action: DetailActionProtocol?
    private (set) var hero: Hero?
    let database = Database()
}
