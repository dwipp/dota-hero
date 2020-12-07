//
//  RolesVM.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import Foundation

protocol RolesActionProtocol {
    func afterFetchRoles()
}

protocol RolesModelProtocol {
    var action: RolesActionProtocol? {get set}
    var data: [String] {get}
    func fetchRoles()
}

protocol RolesDelegate {
    func rolesDidSelect(_ role:String)
}

class RolesVM: RolesModelProtocol {
    var action: RolesActionProtocol?
    private (set) var data: [String] = []
    private let database = Database()
    
    func fetchRoles() {
        let heroes = database.fetch(Hero.self)
        data.append(NSLocalizedString("All", comment: ""))
        for hero in heroes {
            data.append(contentsOf: hero.roles)
        }
        data = data.uniques
        self.action?.afterFetchRoles()
    }
    
}
