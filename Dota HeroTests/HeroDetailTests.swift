//
//  HeroDetailTests.swift
//  Dota HeroTests
//
//  Created by Dwi Putra on 06/12/20.
//

import XCTest
@testable import Dota_Hero

class HeroDetailTests: XCTestCase {
    let database = Database()
    let detail = HeroDetailVM()
    let heroID = 9999

    override func setUpWithError() throws {
        database.deleteAllData()
        
    }

    override func tearDownWithError() throws {
        database.deleteAllData()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSuggestHeroGet3(){
        let listHero = Hero()
        listHero.id = heroID
        listHero.primaryAttr.value = .agi
        let arr = ["Carry", "Escape", "Nuker"]
        listHero.roles.append(objectsIn: arr)
        let listHero1 = Hero()
        listHero1.id = heroID+1
        listHero1.primaryAttr.value = .agi
        let arr1 = ["Carry", "Escape", "Initiator"]
        listHero1.roles.append(objectsIn: arr1)
        let listHero2 = Hero()
        listHero2.id = heroID+2
        listHero2.primaryAttr.value = .agi
        let arr2 = ["Carry", "Escape", "Nuker"]
        listHero2.roles.append(objectsIn: arr2)
        let listHero12 = Hero()
        listHero12.id = heroID+12
        listHero12.primaryAttr.value = .agi
        let arr12 = ["Carry", "Escape", "Initiator"]
        listHero12.roles.append(objectsIn: arr12)
        let listHero3 = Hero()
        listHero3.id = heroID+3
        listHero3.primaryAttr.value = .str
        let arr3 = ["Carry", "Escape", "Nuker"]
        listHero3.roles.append(objectsIn: arr3)
        let listHero15 = Hero()
        listHero15.id = heroID+16
        listHero15.primaryAttr.value = .int
        let arr15 = ["Carry", "Escape", "Initiator"]
        listHero15.roles.append(objectsIn: arr15)
        database.save([listHero,listHero1,listHero2,listHero12,listHero3,listHero15])
        
        guard let hero = database.fetch(Hero.self, with: heroID) else {return}
        detail.fetchSuggestedHeroes(by: hero)
        XCTAssertEqual(detail.heroes.count, 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
