//
//  HeroDetailVM.swift
//  Dota Hero
//
//  Created by Dwi Putra on 05/12/20.
//

import Foundation

protocol DetailActionProtocol {
    func afterFetchSuggestedHeroes()
}

protocol DetailModelProtocol {
    var action: DetailActionProtocol? {get set}
    var heroes: [Hero] {get}
    func fetchSuggestedHeroes(by hero:Hero)
}

protocol DetailDelegate {
    func didSelectSuggested(_ id:Int)
}

class HeroDetailVM: DetailModelProtocol {
    var action: DetailActionProtocol?
    private (set) var heroes: [Hero] = []
    let database = Database()
    
    func fetchSuggestedHeroes(by hero: Hero) {
        guard let attr = hero.primaryAttr.value else {return}
        var roles:[String] = []
        roles.append(contentsOf: hero.roles)
        heroes = database.fetch(Hero.self).filter{$0.id != hero.id}.filter{hero.primaryAttr == $0.primaryAttr}
        heroes = heroes.filter({ (collectedHero) -> Bool in
            var collectedRoles:[String] = []
            collectedRoles.append(contentsOf: collectedHero.roles)
            return roles.contains(array: collectedRoles)
        })
        switch attr {
        case .agi:
            heroes = heroes.sorted{$0.moveSpeed > $1.moveSpeed}
        case .str:
            heroes = heroes.sorted{$0.baseAttackMax > $1.baseAttackMax}
        case .int:
            heroes = heroes.sorted{$0.baseMana > $1.baseMana}
        }
        heroes = Array(heroes.prefix(3))
        self.action?.afterFetchSuggestedHeroes()
    }
}
