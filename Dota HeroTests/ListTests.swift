//
//  ListTests.swift
//  Dota HeroTests
//
//  Created by Dwi Putra on 04/12/20.
//

import XCTest
@testable import Dota_Hero

class ListTests: XCTestCase {
    let list = ListVM()
    let database = Database()
    let heroID = 999999
    override func setUpWithError() throws {
        database.deleteAllData()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        database.deleteAllData()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSaveAndFetchDB(){
        let listHero = Hero()
        listHero.id = heroID
        database.save([listHero])
        let hero = database.fetch(Hero.self)
        
        XCTAssertEqual(hero.last?.id, heroID)
    }
    
    func testDeleteDB(){
        let listHero = Hero()
        listHero.id = heroID
        database.save([listHero])
        database.delete(Hero.self, with: heroID)
        let hero = database.fetch(Hero.self)
        
        XCTAssertNotEqual(hero.last?.id, heroID)
    }
    
    func testListFilterFound(){
        let listHero = Hero()
        listHero.id = heroID
        let arr = ["Carry", "Escape", "Nuker"]
        listHero.roles.append(objectsIn: arr)
        let listHero1 = Hero()
        listHero1.id = heroID+1
        let arr1 = ["Carry", "Escape", "Initiator"]
        listHero1.roles.append(objectsIn: arr1)
        database.save([listHero,listHero1])
        
        list.fetchLocalList(isCache: false, role: "Initiator")
        
        XCTAssertEqual(list.data.first?.id, heroID+1)
    }
    
    func testListFilterNil(){
        let listHero = Hero()
        listHero.id = heroID
        let arr = ["Carry", "Escape", "Nuker"]
        listHero.roles.append(objectsIn: arr)
        let listHero1 = Hero()
        listHero1.id = heroID+1
        let arr1 = ["Carry", "Escape", "Initiator"]
        listHero1.roles.append(objectsIn: arr1)
        database.save([listHero,listHero1])
        
        list.fetchLocalList(isCache: false, role: "Jungler")
        
        XCTAssertNil(list.data.first?.id)
    }
    
    func testFetchHeroNotNil(){
        let listHero = Hero()
        listHero.id = heroID
        database.save([listHero])
        let hero = database.fetch(Hero.self, with: heroID)
        
        XCTAssertNotNil(hero)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
